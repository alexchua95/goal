class LandingsController < ApplicationController

  def create
    @landing = Landing.new(landing_params)
    respond_to do |format|
      if @landing.save
        format.js { render layout: false }
      end
    end
  end

  def update
    @landing = Landing.find(params[:id])
    @landing.update(landing_params)
    respond_to do |format|
      if @landing.save
        format.js { render layout: false }
      end
    end
  end

  def landing_params
    if params[:landing][:other_skills]
      params[:landing][:other_skills] = params[:landing][:other_skills].split(',')
    end
    params.require(:landing).permit(:email, :role, other_skills: [], skills: [])
  end

end