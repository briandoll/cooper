require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

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
        @category = Factory(:category)
        get :show, :id => @category.id
      end
      
      should_respond_with :success
      should_render_template :show
      should_not_set_the_flash
      should_assign_to :category, :class => Category, :equals => '@category'
    end

    context "on GET to :new" do
      setup { get :new }
      
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash
      should_assign_to :category, :class => Category, :equals => '@category'
      should_render_a_form
    end
    
    context "on POST to :create" do
      setup { post :create, :category => {:name => 'MEAT!'} }
      
      should_assign_to :category
      should_redirect_to "categories_path" 
      should_set_the_flash_to(/saved/i)
    end    

    context "on GET to :edit" do
      setup do
        @category = Factory(:category)
        get :edit, :id => @category.id
      end
      
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash
      should_assign_to :category, :class => Category, :equals => '@category'
      should_render_a_form
    end
    
    context "on POST to :update" do
      setup do
        @category = Factory(:category)
        post :update, :id => @category.id, :category => {:name => 'MEAT!!!!'}
      end
      
      should_assign_to :category
      should_redirect_to "categories_path" 
      should_set_the_flash_to(/saved/i)
    end
    
    context "on POST to :destroy" do
      setup do
        @category = Factory(:category)
        post :destroy, :id => @category.id
      end
      
      should_assign_to :category
      should_redirect_to "categories_path" 
      should_set_the_flash_to(/deleted/i)
    end
    
    
  end

end
