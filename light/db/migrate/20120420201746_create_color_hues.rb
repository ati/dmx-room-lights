class CreateColorHues < ActiveRecord::Migration
  def change
    create_table :color_hues do |t|
      t.references :color_group
      t.float :distance
      t.integer :h

      t.timestamps
    end
    add_index :color_hues, :color_group_id
  end
end
