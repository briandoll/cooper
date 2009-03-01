require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  should_have_db_column :name, :type => "string", :default => nil
  should_have_many :products
  
  context "a category with one product" do 
    setup do
      @category = Factory(:product).category      
    end
    
    should "return the available products" do
      assert(@category.available_products.size == 1)
    end
    
  end
  
end
