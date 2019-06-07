class UsersController < ApplicationController

  before_action: admin_only, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params(:username, :password))
    if @user.save
      session[:user_id] = @user.id
      redirect_to wines_path
    else
      render new_user_path
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params(:username, :password, :admin))
    if @user.save?
      redirect_to user_path(@user)
    else
      render 'user/edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.reviews.each { |review| review.destroy }
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params(* args)
    params.require(:user).permit(args)
  end
end
