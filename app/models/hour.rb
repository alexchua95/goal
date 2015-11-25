class Hour
  include Mongoid::Document
  embedded_in :user
  field :day, type: String
  field :start, type: Integer
  field :end, type: Integer
end