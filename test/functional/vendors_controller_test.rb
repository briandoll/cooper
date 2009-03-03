require 'test_helper'

class VendorsControllerTest < ActionController::TestCase

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
        @vendor = Factory(:vendor)
        get :show, :id => @vendor.id
      end
      
      should_respond_with :success
      should_render_template :show
      should_not_set_the_flash
      should_assign_to :vendor, :class => Vendor, :equals => '@vendor'
    end

    context "on GET to :new" do
      setup { get :new }
      
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash
      should_assign_to :vendor, :class => Vendor, :equals => '@vendor'
      should_render_a_form
    end
    
    context "on POST to :create" do
      setup { post :create, :vendor => Factory.attributes_for(:vendor) }
      
      should_assign_to :vendor
      should_redirect_to "vendors_path" 
      should_set_the_flash_to(/saved/i)
    end    

    context "on GET to :edit" do
      setup do
        @vendor = Factory(:vendor)
        get :edit, :id => @vendor.id
      end
      
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash
      should_assign_to :vendor, :class => Vendor, :equals => '@vendor'
      should_render_a_form
    end
    
    context "on POST to :update" do
      setup do
        @vendor = Factory(:vendor)
        post :update, :id => @vendor.id, :vendor => Factory.attributes_for(:vendor)
      end
      
      should_assign_to :vendor
      should_redirect_to "vendors_path" 
      should_set_the_flash_to(/saved/i)
    end
    
    context "on POST to :destroy" do
      setup do
        @vendor = Factory(:vendor)
        post :destroy, :id => @vendor.id
      end
      
      should_assign_to :vendor
      should_redirect_to "vendors_path" 
      should_set_the_flash_to(/deleted/i)
    end
    
    
  end
end
