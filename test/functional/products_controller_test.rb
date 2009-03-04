require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

  context "logged in as an admin" do
    setup { login_as :quentin }

    context "on GET to :index" do
      setup { get :index }
      
      should_respond_with :success
      should_render_template :index
      should_not_set_the_flash      
    end

    context "on GET to :show" do
      setup do
        @product = Factory(:product)
        get :show, :id => @product.id
      end
      
      should_respond_with :success
      should_render_template :show
      should_not_set_the_flash
      should_assign_to :product, :class => Product, :equals => '@product'
    end

    context "on GET to :new" do
      setup { get :new }
      
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash
      should_assign_to :product, :class => Product, :equals => '@product'
      should_render_a_form
    end
    
    context "on POST to :create" do
      setup do
        @category = Factory(:category)
        @vendor   = Factory(:vendor)
        post :create, :product => 
          Factory.attributes_for(:product, :category_id => @category.id, :vendor_id => @vendor.id)
      end
      
      should_assign_to :product
      should_redirect_to "products_url" 
      should_set_the_flash_to(/saved/i)
    end    

    context "on GET to :edit" do
      setup do
        @product = Factory(:product)
        get :edit, :id => @product.id
      end
      
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash
      should_assign_to :product, :class => Product, :equals => '@product'
      should_render_a_form
    end
    
    context "on POST to :update" do
      setup do
        @product = Factory(:product)
        @category = Factory(:category)
        @vendor   = Factory(:vendor)
        post :update, :id => @product.id, :product => 
          Factory.attributes_for(:product, :category_id => @category.id, :vendor_id => @vendor.id)
      end
      
      should_assign_to :product
      should_redirect_to "products_url" 
      should_set_the_flash_to(/saved/i)
    end
    
    context "on POST to :destroy" do
      setup do
        @product = Factory(:product)
        post :destroy, :id => @product.id
      end
      
      should_assign_to :product
      should_redirect_to "products_url" 
      should_set_the_flash_to(/deleted/i)
    end
    
    
  end

end
