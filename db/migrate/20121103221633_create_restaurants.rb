class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :count_tables
      t.integer :reservation_length

      t.timestamps
    end
  end
end
