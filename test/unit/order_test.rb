require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  should_belong_to  :user
  should_have_many  :order_items
  
  context "an open order" do 
    setup do 
      @order = Factory(:user).open_order
      @product = Factory(:product)
    end
    
    should "have a status of open" do
      assert(Order::STATUS[Order::STATUS_OPEN].eql?(@order.status))
    end
    
    should "appear in the open_orders method" do
      assert_contains(Order.open_orders, @order)
    end
    
    should "have have no items" do
      assert(@order.items.size == 0)
    end

    should "allow items to be added to it" do
      @order.add_item(@product, 4)
      assert(@order.items.size == 1)
    end

    context "with one item with a quantity of two" do
      setup do
        @order.add_item(@product, 2)
      end
    
      should "return an increased quantity when the same product is added again" do
        @order.add_item(@product, 1)        
        assert(@order.items.first.quantity == 3)
      end
    end    

  end
    
  context "a submitted order" do 
    setup do 
      @order = Factory(:user).open_order
      @order.status = Order::STATUS_SUBMITTED
      @order.save
    end
    
    should "appear in the submitted_orders method" do 
      assert_contains(Order.submitted_orders, @order)
    end
    
    should "now allow items to be added to it" do
      assert_raise RuntimeError do
        @order.add_item(@product, 1)
      end
    end
  end
end
