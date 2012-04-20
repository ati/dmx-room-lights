class CreateGalaxies < ActiveRecord::Migration
  def change
    create_table :galaxies do |t|
      t.text :displayname

      t.timestamps
    end
  end
end
