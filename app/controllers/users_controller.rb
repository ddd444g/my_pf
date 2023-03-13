class UsersController < ApplicationController
  def index
    @users = User.all
    @spots = Spot.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    if @user.save
      flash[:notice] = 'ユーザーを新規登録しました'
      redirect_to :users
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @spot = Spot.new
    @spots = @user.spots
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:name, :email, :password, :password_confirmation))
      flash[:notice] = "ユーザーIDが「#{@user.id}」の情報を更新しました"
      redirect_to :users
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました'
    redirect_to :users
  end
end
