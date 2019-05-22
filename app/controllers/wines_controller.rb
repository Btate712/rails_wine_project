class WinesController < ApplicationController
  def index
    @wines = Wine.all
  end

  def show
    @wine = Wine.find(params[:id])
  end

  def new
    @wine = Wine.new
  end

  def edit
    @wine = Wine.find(params[:id])
  end

  def create
    @wine = Wine.new(wine_params)
    if @wine.save?
      redirect_to wines_path
    else
      render 'wine/new'
    end
  end

  def update
    @wine = Wine.find(params[:id])
    @wine.update(wine_params)
    if @wine.save?
      redirect_to wine_path(@wine)
    else
      render 'wine/edit'
    end
  end

  def destroy
    @user = Wine.find(params[:id])
    @user.destroy
    redirect_to wines_path 
  end

  private

  def user_params(* args)
    params.require(:wine).permit(:name, :variety_id)
  end
end
