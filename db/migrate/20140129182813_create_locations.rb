class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :venue
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zipcode

      t.timestamps
    end
  end
end
