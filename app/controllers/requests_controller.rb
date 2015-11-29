class RequestsController < ApplicationController

  def index
    @requests = current_user.requests
    @skills = current_user.skills.includes(:requests)
  end

  def cancel
    @request = Request.find(params[:request_id])
    respond_to do |format|
      if @request.cancel!
        @requests = current_user.requests
        @skills = current_user.skills.includes(:requests)
        format.js { render :update_requests }
      else
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def decline
    @request = Request.find(params[:request_id])
    respond_to do |format|
      if @request.decline!
        @requests = current_user.requests
        @skills = current_user.skills.includes(:requests)
        format.js { render :update_requests }
      else
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    @request = Request.find(params[:request_id])
    respond_to do |format|
      if @request.accept!
        @requests = current_user.requests
        @skills = current_user.skills.includes(:requests)
        format.js { render :update_requests }
      else
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

end