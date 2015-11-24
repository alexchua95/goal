class RequestsController < ApplicationController

  def new
    @skill = Skill.find(params[:skill_id])
    @request = Request.new
  end

  def create
    @request = current_user.requests.new(request_params)
    @request.save
    redirect_to root_path
  end

  def request_params
    params.require(:request).permit(:skill_id, :rate, :start_time, :end_time)
  end

end