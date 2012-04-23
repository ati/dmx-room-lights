class CreateFixtures < ActiveRecord::Migration
  def change
    create_table :fixtures do |t|
      t.references :galaxy
      t.integer :r
      t.integer :g
      t.integer :b
      t.float :distance

      t.timestamps
    end
  end
end
