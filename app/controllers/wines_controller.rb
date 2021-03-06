class WinesController < ApplicationController
  before_action :require_login
  before_action :admin_only, only: [:edit, :update, :destroy]

  def index
    if params[:wine_color] && params[:wine_color] != 'all'
      @wines = Wine.selected_color(params[:wine_color])
    else
      @wines = Wine.all
    end
    @wines = @wines.sort_by{ |wine| wine.average_rating }.reverse
  end

  def show
    @wine = Wine.find(params[:id])
  end

  def new
    @wine = Wine.new
    @varieties = Variety.all
    @wine.build_variety
  end

  def edit
    @wine = Wine.find(params[:id])
    @varieties = Variety.all
  end

  def create
    @wine = Wine.new(wine_params)
    if @wine.save
      redirect_to wine_path(@wine)
    else
      @varieties = Variety.all
      render 'wines/new'
    end
  end

  def update
    @wine = Wine.find(params[:id])
    @wine.update(wine_params)
    if @wine.save
      redirect_to wine_path(@wine)
    else
      render 'wine/edit'
    end
  end

  def destroy
    @wine = Wine.find(params[:id])
    @wine.reviews.each { |review| review.destroy }
    @wine.destroy
    redirect_to wines_path
  end

  private

  def wine_params
    params.require(:wine).permit(:name, :variety_id, variety_attributes: [:name, :color])
  end
end
