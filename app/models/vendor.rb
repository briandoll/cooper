class Vendor < ActiveRecord::Base
  has_many :products
  validates_presence_of :description
  validates_presence_of :contact_info
  
  before_save :textilize
  
  def available_products
    products.select{|p| p.available?}
  end
  
  def textilize
    desc    = RedCloth.new(description).to_html
    contact = RedCloth.new(contact_info).to_html
    self.description_html  = desc.gsub("\n","").gsub("\t","")
    self.contact_info_html = contact.gsub("\n","").gsub("\t","")
  end
  
  def to_param
    "#{id}-#{slug_name}"
  end
  
  def slug_name
    name.downcase.gsub(/[^a-z0-9]+/,'-').gsub(/-+&$/, '').gsub(/^-+$/, '')
  end
  
end
