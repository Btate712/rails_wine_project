class VarietiesController < ApplicationController
  before_action :require_login

  def index
    @varieties = Variety.all
  end

  def show
    @variety = Variety.find(params[:id])
    @wines = Wine.by_variety(@variety)
  end

  def new
    @variety = Variety.new
  end

  def edit
    admin_only
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
    admin_only
    @variety = Variety.find(params[:id])
    @variety.update(variety_params)
    if @variety.save
      redirect_to variety_path(@variety)
    else
      render 'variety/edit'
    end
  end

  def destroy
    admin_only
    @variety = Variety.find(params[:id])
    @variety.destroy
    redirect_to varieties_path
  end

  private

  def variety_params
    params.require(:variety).permit(:name, :color)
  end
end
