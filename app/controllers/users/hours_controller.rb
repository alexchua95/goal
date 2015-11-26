class Users::HoursController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @hour = @user.hours.new(hour_params)
    respond_to do |format|
      if @hour.save
        format.json { render 'create', status: :created }
      else
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @hour = User.find(params[:user_id]).hours.find(params[:id])
    respond_to do |format|
      if @hour.update(hour_params)
        format.json { render 'update', status: :created }
      else
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @hour = User.find(params[:user_id]).hours.find(params[:id])
    respond_to do |format|
      if @hour.destroy
        format.json { head :no_content }
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