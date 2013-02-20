class RemoveNameFromSites < ActiveRecord::Migration

  def change
	remove_column :sites, :name
  end

  def up
    remove_column :sites, :name
  end

  def down
    add_column :sites, :name, :string
  end
end
