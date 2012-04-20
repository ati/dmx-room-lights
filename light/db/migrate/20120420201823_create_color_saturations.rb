class CreateColorSaturations < ActiveRecord::Migration
  def change
    create_table :color_saturations do |t|
      t.references :color_group
      t.float :distance
      t.integer :s

      t.timestamps
    end
    add_index :color_saturations, :color_group_id
  end
end
