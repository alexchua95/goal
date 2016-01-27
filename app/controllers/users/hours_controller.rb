class Users::HoursController < ApplicationController

  def create
    @hour = User.find(params[:user_id]).hours.new(hour_params)
    respond_to do |format|
      if @hour.save
        @user = User.find(params[:user_id])
        format.json { render 'shared/user', status: :created }
      else
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @hour = User.find(params[:user_id]).hours.find(params[:id])
    respond_to do |format|
      if @hour.update(hour_params)
        @user = User.find(params[:user_id])
        format.json { render 'shared/user', status: :ok }
      else
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @hour =  User.find(params[:user_id]).hours.find(params[:id])
    respond_to do |format|
      if @hour.destroy
        @user = User.find(params[:user_id])
        format.js { render layout: false }
      else
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def hour_params
    params[:hour][:open] = Hour.time_string_to_integer(params[:hour][:open_time])
    params[:hour][:close] = Hour.time_string_to_integer(params[:hour][:close_time])
    params.require(:hour).permit(:day, :open, :close)
  end

end