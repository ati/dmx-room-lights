class CreateColorValues < ActiveRecord::Migration
  def change
    create_table :color_values do |t|
      t.references :color_group
      t.float :distance
      t.integer :v

      t.timestamps
    end
    add_index :color_values, :color_group_id
  end
end
