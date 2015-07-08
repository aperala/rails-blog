class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.timestamps null: false
      #created_at
      #updated_at
    end
  end
end
