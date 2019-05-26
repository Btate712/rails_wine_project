class WinesController < ApplicationController
  before_action :require_login

  def index
    @wines = Wine.all
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
    @wine.destroy
    redirect_to wines_path
  end

  private

  def wine_params
    params.require(:wine).permit(:name, :variety_id, variety_attributes: [:id, :name, :color])
  end
end
