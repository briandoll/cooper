class ProductsController < ApplicationController
  before_filter :ensure_logged_in
  before_filter :ensure_current_user_is_admin, :except => [:show]

  def index
    @products = Product.available
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    begin
      @product = Product.new(params[:product])
      @product.save!
      flash[:success] = "Your product has been saved!"       
      redirect_to products_url

    rescue ActiveRecord::RecordInvalid
      flash.now[:failure] = "Could not save your changes."
      render :action => 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
    render :action => 'new'
  end

  def update
    @product = Product.find(params[:id])
    updated = @product.update_attributes(params[:product])  
    if updated
      flash[:success] = "Your changes have been saved."
      redirect_to products_url

    else
      flash.now[:failure] = "Could not save your changes."
      render :action => 'new'
    end
  end

  def destroy    
    @product = Product.find(params[:id])
    @product.destroy
    flash[:success] = "The product has been deleted."
    redirect_to products_url
  end

end
