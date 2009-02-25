require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  should_belong_to :category
  should_allow_values_for :name, "foo"
  should_allow_values_for :description, "foo"
  
  context "with a valid, available product" do 
    setup do 
      @product = Factory(:product)      
    end
    
    should "appear in the available scope" do      
      assert(Product.available.include? @product)
    end
    
    should  "be available" do
      assert(@product.available?)
    end
  end
end
