class UsersController < ApplicationController

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
    admin_only
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params(:username, :password))
    if @user.save
      session[:user_id] = @user.id
      redirect_to wines_path
    else
      render 'user/new'
    end
  end

  def update
    admin_only
    @user = User.find(params[:id])
    @user.update(user_params(:username, :password, :admin))
    if @user.save?
      redirect_to user_path(@user)
    else
      render 'user/edit'
    end
  end

  def destroy
    admin_only
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params(* args)
    params.require(:user).permit(args)
  end
end
