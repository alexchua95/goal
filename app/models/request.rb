class Request
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :skill
  default_scope -> { where(:status.ne => :cancelled) }
  field :rate, type: Float
  field :start_time, type: Time
  field :length, type: Float
  field :status, type: String, default: 'pending'
  validates :status, inclusion: { in: %w(pending accepted declined cancelled), message: '%{value} is not a valid status' }
  validates_presence_of :rate, :start_time, :length, :skill, :user, :status

  def cancel!
    self.status = 'cancelled'
    save
  end

  def pending?
    self.status == 'pending'
  end

  def formatted_start_time
    self.start_time.strftime('%a, %b %d, %Y %l:%M%P')
  end

  def accept!
    self.status = 'accepted'
    save
  end

  def decline!
    self.status = 'declined'
    save
  end

end