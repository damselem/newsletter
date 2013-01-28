class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
    end
  end
end
