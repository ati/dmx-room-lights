class AddGroupTypeToColorGroup < ActiveRecord::Migration
  def change
    add_column :color_groups, :group_type, :text
  end
end
