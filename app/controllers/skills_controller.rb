class SkillsController < ApplicationController

  def new
    @skill_types = SkillType.all
    @skill = Skill.new
  end

  def create
    @skill = current_user.skills.new(skill_params)
    @skill.save
    redirect_to root_path
  end

  def index
    @skills = Skill.includes(:user).includes(:skill_type).all
  end

  def skill_params
    params.require(:skill).permit(:skill_type_id, :level, :rate_min, :rate_max)
  end

end