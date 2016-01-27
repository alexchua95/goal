class Landing
  include Mongoid::Document
  include Mongoid::Timestamps
  field :email, type: String
  field :roles, type: Array, default: []
  field :skills, type: Array, default: []

  before_save :remove_empty

  def self.roles
    %w(teacher learner)
  end

  def remove_empty
    roles.reject!(&:empty?)
    skills.reject!(&:empty?)
  end

  def self.skills
    %w(snowboarding boxing singing magic guitar coding art skiing cooking)
  end

  # validates :roles, inclusion: Landing.roles
  # validates :skills, inclusion: Landing.skills
end