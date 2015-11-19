class BusinessesController < ApplicationController
  before_action :require_user, only: [:new, :create]
  before_action :set_business, only: [:show]

  def index
    @businesses = Business.all
  end

  def show
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.create(business_params)
    if @business.save
      flash[:notice] = 'The business has been created.'
      redirect_to businesses_path
    else
      flash[:error] = 'The business has not been created'
      render :new
    end
  end

  private

  def business_params
    params.require(:business).permit(:name, :description)
  end

  def set_business
    @business = Business.find_by id: params[:id]
  end

end