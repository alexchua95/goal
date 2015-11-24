class Skill
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :skill_type
  belongs_to :user
  field :level, type: Integer
  field :rate_min, type: Float
  field :rate_max, type: Float

  def level_name
    if self.level == 0
      return "Noob"
    elsif self.level == 1
      return "Getting Better"
    else
      return "Expert"
    end
  end
end