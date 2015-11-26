class Users::HoursController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @hour = @user.hours.new(hour_params)
    respond_to do |format|
      if @hour.save
        format.html { redirect_to @hour, notice: 'User was successfully created.' }
        format.js   {}
        format.json { render 'create', status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @hour = User.find(params[:user_id]).hours.find(params[:id])
    respond_to do |format|
      if @hour.update(hour_params)
        format.html { redirect_to @hour, notice: 'User was successfully created.' }
        format.js   {}
        format.json { render 'update', status: :created }
      else
        format.html { render action: "new" }
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