class Skill
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :skill_type
  belongs_to :user
  field :level, type: Integer
  field :rate_min, type: Float
  field :rate_max, type: Float
end