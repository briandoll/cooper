class CategoriesController < ApplicationController
  before_filter :ensure_logged_in
  
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    begin
      @category = Category.new(params[:category])
      @category.save!
      flash[:success] = "Your category has been saved!"       
      redirect_to categories_url

    rescue ActiveRecord::RecordInvalid
      flash.now[:failure] = "Could not save your changes."
      render :action => 'edit'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    updated = @category.update_attributes(params[:category])  
    if updated
      flash[:success] = "Your changes have been saved."
      redirect_to categories_url

    else
      flash.now[:failure] = "Could not save your changes."
      render :action => 'edit'
    end
  end

  def destroy    
    @category = Category.find(params[:id])
    @category.destroy
    flash[:success] = "The category has been deleted."
    redirect_to categories_url
  end

end
