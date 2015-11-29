class Users::LocationsController < ApplicationController

  def create
    @location = User.find(params[:user_id]).build_location(location_params)
    respond_to do |format|
      if @location.save
        @user = User.find(params[:user_id])
        format.json { render 'shared/user', status: :created }
      else
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @location = User.find(params[:user_id]).location
    respond_to do |format|
      if @location.update(location_params)
        @user = User.find(params[:user_id])
        format.json { render 'shared/user', status: :ok }
      else
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def location_params
    params.require(:location).permit(:address, :latitude, :longitude)
  end

end