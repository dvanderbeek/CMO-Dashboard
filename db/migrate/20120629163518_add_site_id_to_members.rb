class AddSiteIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :site_id, :integer
  end
end
