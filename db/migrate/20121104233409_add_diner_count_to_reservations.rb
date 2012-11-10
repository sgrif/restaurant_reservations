class AddDinerCountToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :diner_count, :integer
  end
end
