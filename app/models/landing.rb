class Landing
  include Mongoid::Document
  include Mongoid::Timestamps
  field :email, type: String
  field :role, type: String
  field :skills, type: Array, default: []
  field :other_skills, type: Array, default: []

  before_save :remove_empty

  def self.roles
    %w(teacher learner both)
  end

  def remove_empty
    skills.reject!(&:empty?)
  end

  def self.skills
    %w(snowboarding martial singing magic guitar coding art skiing cooking)
    ['snow sports','martial arts','music','coding','cooking','art','sports','magic','academics']
  end

  # validates :roles, inclusion: Landing.roles
  # validates :skills, inclusion: Landing.skills
end