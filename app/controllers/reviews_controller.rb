class ReviewsController < ApplicationController
  before_action :require_login

  def index
    if params[:user_id] && User.exists?(params[:user_id])
      @list_by = "user"
      @reviews = User.find(params[:user_id]).reviews
    elsif params[:wine_id] && Wine.exists?(params[:wine_id])
      @list_by = "wine"
      @reviews = Wine.find(params[:wine_id]).reviews
    else
      @list_by = nil
      @reviews = Review.all
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
    @wines = Wine.all
    @wine = @review.build_wine
    @variety = @wine.build_variety
    @varieties = Variety.all
    if params[:wine_id] && Wine.exists?(params[:wine_id])
      @review.wine = Wine.find(params[:wine_id])
      @disable_wine_select = true
    else
      @disable_wine_select = false
    end
  end

  def edit
    @review = Review.find(params[:id])
    redirect_to wines_path if @review.user != current_user
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
    redirect_to wines_path if current_user != @review.user
    @review.update(review_params)
    if @review.save
      redirect_to review_path(@review)
    else
      render 'review/edit'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    redirect_to wines_path if @review.user != current_user
    @review.destroy
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :wine_id, :rating, :heaviness,
      :fruitiness, :acidity, :comments, wine_attributes:
        [:name, :variety_id, variety_attributes:
          [:name, :color]
        ]
      )
  end
end
