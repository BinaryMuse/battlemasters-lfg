class AddBattlegroupToListing < ActiveRecord::Migration
  def change
    add_column :listings, :battlegroup, :string

  end
end
