class AddStartAddressToFixtures < ActiveRecord::Migration
  def change
    add_column :fixtures, :start_address, :integer
    add_index :fixtures, :start_address, :unique => true
  end
end
