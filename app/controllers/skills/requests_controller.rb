class Skills::RequestsController < ApplicationController

  def new
    @skill = Skill.find(params[:skill_id])
    @request = Request.new
  end

  def create
    @request = current_user.requests.new(request_params)
    @request.save
    redirect_to root_path
  end

  def date_time_format
    '%m/%d/%Y %I:%M %p'
  end

  def request_params
    params[:request][:start_time] = DateTime.strptime(params[:request][:start_time], date_time_format)
    params[:request][:end_time] = DateTime.strptime(params[:request][:end_time], date_time_format)
    params.require(:request).permit(:skill_id, :rate, :start_time, :end_time)
  end

end