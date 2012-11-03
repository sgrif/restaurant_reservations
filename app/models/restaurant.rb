class Restaurant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :count_tables, :reservation_length

  validates :name, presence: true
  validates :count_tables, presence: true, numericality: { greater_than: 0 }
  validates :reservation_length, presence: true, numericality: { greater_than_or_equal_to: 15 }
end
