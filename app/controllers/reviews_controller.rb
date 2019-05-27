class ReviewsController < ApplicationController
  before_action :require_login

  def index
    if params[:user_id] && User.exists?(params[:user_id])
      @by = "user"
      @reviews = User.find(params[:user_id]).reviews
    elsif params[:wine_id] && Wine.exists?(params[:wine_id])
      @by = "wine"
      @reviews = Wine.find(params[:wine_id]).reviews
    else
      @by = nil
      @reviews = Review.all
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
    @wines = Wine.all
  end

  def edit
    @review = Review.find(params[:id])
    @wines = Wine.all
  end

  def create
    @review = Review.new(review_params)
    if @review.save!
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
    params.require(:review).permit(:user_id, :wine_id, :rating, :heaviness,
      :fruitiness, :acidity, :comments)
  end
end
