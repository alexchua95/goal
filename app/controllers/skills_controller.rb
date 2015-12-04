class SkillsController < ApplicationController

  def new
    @skill_types = SkillType.all
    @skill = Skill.new
  end

  def edit
    @skill_types = SkillType.all
    @skill = Skill.includes(:skill_type).find(params[:id])
  end

  def create
    @skill_types = SkillType.all
    @skill = current_user.skills.new(skill_params)
    if @skill.save
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def destroy
    @skill = Skill.find(params[:id])
    if @skill.destroy
      redirect_to user_path(current_user)
    else

    end
  end

  def update
    @skill = Skill.find(params[:id])
    if @skill.update(skill_params)
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