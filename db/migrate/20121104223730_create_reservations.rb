class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations, id: false do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :name
      t.belongs_to :restaurant
      t.string :confirmation_token

      t.timestamps
    end
    add_index :reservations, :confirmation_token, unique: true
    add_index :reservations, [:restaurant_id, :starts_at, :ends_at]
  end
end
