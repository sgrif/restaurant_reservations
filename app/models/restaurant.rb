class Restaurant < ActiveRecord::Base
  DINERS_PER_TABLE = 4

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reservations, inverse_of: :restaurant

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :count_tables, :reservation_length

  validates :name, presence: true
  validates :count_tables, presence: true, numericality: { greater_than: 0 }
  validates :reservation_length, presence: true, numericality: { greater_than_or_equal_to: 15 }

  def available_tables_for_span(range)
    count_tables - reservations.count_during(range)
  end
end
