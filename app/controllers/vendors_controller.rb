class VendorsController < ApplicationController
  before_filter :ensure_current_user_is_admin

  def index
    @vendors = Vendor.all
  end

  def show
    @vendor = Vendor.find(params[:id])
  end

  def new
    @vendor = Vendor.new
  end

  def create
    begin
      @vendor = Vendor.new(params[:vendor])
      @vendor.save!
      flash[:success] = "Your vendor has been saved!"       
      redirect_to vendors_url

    rescue ActiveRecord::RecordInvalid
      flash.now[:failure] = "Could not save your changes."
      render :action => 'new'
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
    render :action => 'new'
  end

  def update
    @vendor = Vendor.find(params[:id])
    updated = @vendor.update_attributes(params[:vendor])  
    if updated
      flash[:success] = "Your changes have been saved."
      redirect_to vendors_url

    else
      flash.now[:failure] = "Could not save your changes."
      render :action => 'new'
    end
  end

  def destroy    
    @vendor = Vendor.find(params[:id])
    @vendor.destroy
    flash[:success] = "The vendor has been deleted."
    redirect_to vendors_url
  end

end
