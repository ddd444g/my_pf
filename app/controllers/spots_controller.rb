class SpotsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @spot = Spot.new(params.require(:spot).permit(:memo, :user_id))
    if @spot.save
      flash[:notice] = "新規投稿をしました"
      redirect_to :users
    else
      @user = User.find_by(params[:spot][:user_id])
      render "users/show", status: :unprocessable_entity
    end
  end

  def show
    @spot = Spot.find(params[:id])
  end

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:id])
    if @spot.update(params.require(:spot).permit(:memo))
      flash[:notice] = "投稿を更新しました"
      redirect_to :users
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to :users
  end
end
