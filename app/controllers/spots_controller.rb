class SpotsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @spot = Spot.new(params.require(:spot).permit(:memo, :user_id, :address, :latitude, :longitude))
    if @spot.save
      flash[:notice] = "新規投稿をしました"
      redirect_to :users
    else
      @user = User.find_by(params[:spot][:user_id])
      redirect_to new_spot_path, status: :unprocessable_entity
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
    if @spot.update(params.require(:spot).permit(:memo, :address, :latitude, :longitude))
      flash[:notice] = "投稿を更新しました"
      redirect_to :users
    else
      redirect_to edit_spot_path(@spot), status: :unprocessable_entity
    end
  end

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to :users
  end
end
