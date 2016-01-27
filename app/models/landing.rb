class Landing
  include Mongoid::Document
  field :email, type: String
  field :roles, type: Array, default: []
  field :skills, type: Array, default: []

  def self.roles
    %w(teacher learner)
  end

  def self.skills
    %w(snowboarding boxing singing magic guitar coding art skiing cooking)
  end

  # validates :roles, inclusion: Landing.roles
  # validates :skills, inclusion: Landing.skills
end