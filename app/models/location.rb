class Skill
  include Mongoid::Document
  embedded_in :user
  field :longitude, type: Float
  field :latitude, type: Float
  validates_presence_of :latitude, :longitude
end