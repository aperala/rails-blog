class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :interests, :string
  end
end
