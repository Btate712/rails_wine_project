class VarietiesController < ApplicationController
  before_action :require_login
  before_action :admin_only, only: [:edit, :update, :destroy]

  def popular
    @variety = Variety.popular.first
    # render 'varieties/popular'
  end

  def index
    @varieties = Variety.all
  end

  def show
    if params[:id] == "red" || params[:id] == "white" || params[:id] == "pink"
      @varieties = Variety.selected_color(params[:id])
      render 'varieties/index'
    else
      @variety = Variety.find(params[:id])
      @wines = Wine.by_variety(@variety)
    end
  end

  def new
    @variety = Variety.new
  end

  def edit
    @variety = Variety.find(params[:id])
  end

  def create
    @variety = Variety.new(variety_params)
    if @variety.save
      redirect_to variety_path(@variety)
    else
      @varieties = Variety.all
      render 'varieties/new'
    end
  end

  def update
    @variety = Variety.find(params[:id])
    @variety.update(variety_params)
    if @variety.save
      redirect_to variety_path(@variety)
    else
      render 'variety/edit'
    end
  end

  def destroy
    @variety = Variety.find(params[:id])
    @variety.destroy
    redirect_to varieties_path
  end

  private

  def variety_params
    params.require(:variety).permit(:name, :color)
  end
end
