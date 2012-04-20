class CreateFixtures < ActiveRecord::Migration
  def change
    create_table :fixtures do |t|
      t.references :galaxy
      t.references :color_hue
      t.references :color_saturation
      t.references :color_value
      t.float :distance

      t.timestamps
    end
    add_index :fixtures, :galaxy_id
    add_index :fixtures, :color_hue_id
    add_index :fixtures, :color_saturation_id
    add_index :fixtures, :color_value_id
  end
end
