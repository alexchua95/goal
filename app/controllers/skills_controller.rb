class SkillsController < ApplicationController

  def new
    @skill_types = SkillType.all
    @skill = Skill.includes(:skill_type).new
  end

  def create
    @skill = current_user.skills.new(skill_params)
    if @skill.save
      redirect_to user_path(current_user)
    else

    end

  end

  def index
    @skills = Skill.includes(:user).includes(:skill_type).all
  end

  def skill_params
    params.require(:skill).permit(:skill_type_id, :level, :rate)
  end

end