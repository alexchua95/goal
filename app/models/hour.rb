class Hour
  include Mongoid::Document
  embedded_in :user
  field :day, type: Integer
  field :open, type: Integer
  field :close, type: Integer

  validates :day, inclusion: 0..6
  validates :open, inclusion: 0..1439
  validates :close, inclusion: 0..1439
  validates_presence_of :day, :open, :close

  def day_to_integer(string)

  end

  def open_time
    Hour.integer_to_time_string(open) if open
  end

  def close_time
    Hour.integer_to_time_string(close) if close
  end

  def self.time_string_to_integer(text)
    time = DateTime.parse(text)
    hours = time.strftime("%H").to_i
    minutes = time.strftime("%M").to_i
    hours * 60 + minutes
  end

  def self.integer_to_time_string(number)
    hours = number / 60
    minutes = number % 60
    time = DateTime.parse("#{hours}:#{minutes}")
    time.strftime('%I:%M %p')
  end

  def open_less_than_close
    errors.add(:close, "should be less than total") if close > open
  end

  def self.days
    ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  end

end