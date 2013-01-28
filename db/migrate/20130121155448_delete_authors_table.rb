class DeleteAuthorsTable < ActiveRecord::Migration
  def up
    drop_table :authors
  end

  def down
    create_table :authors do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :email
      t.boolean :validated, :default => false

      t.timestamps
    end
  end
end
