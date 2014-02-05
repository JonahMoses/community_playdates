class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :identity

      t.timestamps
    end
  end
end
