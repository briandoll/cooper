require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  has_many :orders

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  before_create :make_activation_code 

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation

  named_scope :pending_activation, :conditions => ["activated_at IS NULL"]

  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def submitted_orders
    Order.find_all_by_user_id_and_status(id, Order::STATUS_SUBMITTED)
  end

  def completed_orders
    Order.find_all_by_user_id_and_status(id, Order::STATUS_COMPLETE)    
  end
  
  def open_order
    if @open_order && @open_order.open?
      @open_order
    else
      @open_order = find_or_create_open_order
    end    
    @open_order
  end

  def to_param
    "#{id}-#{slug_name}"
  end
  
  def slug_name
    login.downcase.gsub(/[^a-z0-9]+/,'-').gsub(/-+&$/, '').gsub(/^-+$/, '')
  end

  protected
    
    def make_activation_code
        self.activation_code = self.class.make_token
    end

  private
    
    def find_or_create_open_order
      Order.find_by_user_id_and_status(id, Order::STATUS_OPEN) || Order.create(self)
    end

end
