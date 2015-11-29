class Skill
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :skill_type
  belongs_to :user
  has_many :requests
  field :level, type: Integer
  field :rate, type: Float
  validates_presence_of :skill_type, :user, :level, :rate

  def self.levels
    ['Noob', 'Getting Better', 'Expert']
  end

  def skill_type_name
    skill_type.name if skill_type
  end

  def level_name
    Skill.levels[level]
  end

  def self.level_tuples
    result = []
    self.levels.each_with_index do |level, index|
      result << [level, index]
    end
    result
  end
end