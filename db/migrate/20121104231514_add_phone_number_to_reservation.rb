class AddPhoneNumberToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :phone_number, :string
  end
end
