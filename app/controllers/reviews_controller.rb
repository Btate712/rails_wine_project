class ReviewsController < ApplicationController
  before_action :require_login

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
    @varieties = Variety.all
  end

  def edit
    @review = Review.find(params[:id])
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to review_path(@review)
    else
      render 'reviews/new'
    end
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    if @review.save
      redirect_to review_path(@review)
    else
      render 'review/edit'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :wine_id, :comments)
  end
end
