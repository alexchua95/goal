class Skills::RequestsController < ApplicationController

  def new
    @skill = Skill.find(params[:skill_id])
    @request = Request.new(skill: @skill)
  end

  def create
    @request = current_user.requests.new(request_params)
    if @request.save
      redirect_to requests_path
    else

    end

  end

  def request_params
    params[:request][:start_time] = DateTime.parse(params[:request][:start_time])
    params.require(:request).permit(:skill_id, :rate, :start_time, :length)
  end

end