class Category < ActiveRecord::Base
  has_many :products
  
  def to_param
    "#{id}-#{slug_name}"
  end
  
  def slug_name
    name.downcase.gsub(/[^a-z0-9]+/,'-').gsub(/-+&$/, '').gsub(/^-+$/, '')
  end
  
  def available_products
    products.available
  end
    
end
