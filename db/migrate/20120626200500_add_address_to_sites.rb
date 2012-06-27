class AddAddressToSites < ActiveRecord::Migration
  def change
    add_column :sites, :address, :text

  end
end
