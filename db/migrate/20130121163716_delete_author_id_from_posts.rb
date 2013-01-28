class DeleteAuthorIdFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :author_id
  end

  def down
    add_column :posts, :author_id, :integer
  end
end
