class Reservation < ActiveRecord::Base
  belongs_to :restaurant

  self.primary_key = :confirmation_token
  attr_accessible :name, :email, :phone_number, :starts_at, :diner_count

  after_initialize do
    self.starts_at ||= 1.day.from_now.to_datetime.at_beginning_of_hour
    self.diner_count ||= 2
  end

  before_create { generate_token :confirmation_token }

  validates :name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true, length: { in: 7..16 }
  validates :diner_count, numericality: { greater_than: 0 }

  validate :starts_in_future
  validate :ends_after_start
  validate :tables_are_available

  default_scope { order :starts_at }

  def tables_needed
    (self.diner_count.to_f / Restaurant::DINERS_PER_TABLE).ceil
  end

  def starts_at=(starts_at)
    write_attribute :starts_at, starts_at
  end

  def ends_at
    starts_at + restaurant.reservation_length.minutes
  end

  def to_range
    ((starts_at-1.hour)..ends_at)
  end

  def self.expired
    where("starts_at <= ?", 2.hours.ago - Restaurant.first.reservation_length.minutes)
  end

  def self.count_during(range)
    range = range.to_range if range.respond_to?(:to_range)
    t = arel_table
    where(t[:starts_at].in(range)).reduce(0) { |sum, res| sum + res.tables_needed }
  end

  private

  def starts_in_future
    errors.add :starts_at, "must be in future" unless starts_at >= Time.now
  end

  def ends_after_start
    errors.add :ends_at, "must be after start time" unless ends_at > starts_at
  end

  def tables_are_available
    errors.add :starts_at, "not enough available tables for that time" unless restaurant.available_tables_for_span(self) >= tables_needed
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.hex(10)
    end while Reservation.exists?(column => self[column])
  end
end
