class Request
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :skill
  field :rate, type: Float
  field :start_time, type: Time
  field :end_time, type: Time
  validates_presence_of :rate, :start_time, :end_time
end