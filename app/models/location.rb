class Location
  include Mongoid::Document
  embedded_in :user
  field :longitude, type: Float
  field :latitude, type: Float
  field :address, type: String
  validates_presence_of :latitude, :longitude, :address
end