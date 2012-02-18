class AddGenderToListing < ActiveRecord::Migration
  def change
    add_column :listings, :gender, :integer, default: 0
  end
end
