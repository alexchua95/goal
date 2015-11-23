class SkillTypesController < ApplicationController

  def new
    @skill_type = SkillType.new
  end

  def create
    @skill_type = SkillType.new(skill_type_params)
    @skill_type.save
    redirect_to root_path
  end

  private
  def skill_type_params
    params.require(:skill_type).permit(:name)
  end

end