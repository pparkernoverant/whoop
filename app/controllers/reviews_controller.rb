class ReviewsController < ApplicationController
  before_action :require_user, only: [:create]

  def create
    @business = Business.find_by id: review_params[:business_id]

    @review = Review.new(review_params.merge(user_id: current_user.id))
    if @review.save
      flash[:notice] = 'Your review has been created.'
    else
      flash[:error] = 'Your review has not been created.'
    end
    redirect_to business_path(@business)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :business_id)
  end
end