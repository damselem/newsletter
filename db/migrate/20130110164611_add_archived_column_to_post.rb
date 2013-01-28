class AddArchivedColumnToPost < ActiveRecord::Migration
  def change
    add_column :posts, :archived, :boolean, :default => false
  end
end
