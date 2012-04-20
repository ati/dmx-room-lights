class CreateColorGroups < ActiveRecord::Migration
  def change
    create_table :color_groups do |t|
      t.text :displayname

      t.timestamps
    end
  end
end
