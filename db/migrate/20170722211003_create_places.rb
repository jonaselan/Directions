class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :initials
      t.string :address
      t.string :number
      t.string :neighborhood

      t.timestamps
    end
  end
end
