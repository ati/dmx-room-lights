class CreateDisplays < ActiveRecord::Migration
  def change
    create_table :displays do |t|
      t.references :galaxy
      t.references :color_group

      t.timestamps
    end
    add_index :displays, :galaxy_id
    add_index :displays, :color_group_id
  end
end
