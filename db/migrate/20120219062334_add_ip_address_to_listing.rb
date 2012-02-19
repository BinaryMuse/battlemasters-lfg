class AddIpAddressToListing < ActiveRecord::Migration
  def change
    add_column :listings, :ip_address, :string

  end
end
