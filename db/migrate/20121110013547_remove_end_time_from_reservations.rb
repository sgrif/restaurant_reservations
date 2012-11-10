class RemoveEndTimeFromReservations < ActiveRecord::Migration
  def up
    remove_index :reservations, [:restaurant_id, :starts_at, :ends_at]
    remove_column :reservations, :ends_at
    add_index :reservations, [:restaurant_id, :starts_at]
  end

  def down
    raise IrreversableMigrationException.new
  end
end
