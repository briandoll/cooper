class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :vendor
  
  STATUS_AVAILABLE      = 0
  STATUS_UNAVAILABLE    = 1
  
  TYPE_VENDOR_ON_DEMAND = 0
  TYPE_VENDOR_SPECIAL   = 1
  TYPE_STOCKED          = 2
  
  named_scope :available, :conditions => ["status = ?", STATUS_AVAILABLE]
  
  def available?
    STATUS_AVAILABLE == status
  end
  
  def to_param
    "#{id}-#{slug_name}"
  end
  
  def slug_name
    name.downcase.gsub(/[^a-z0-9]+/,'-').gsub(/-+&$/, '').gsub(/^-+$/, '')
  end
    
end
