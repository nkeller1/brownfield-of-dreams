class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string  :email, index: true
      t.string  :first_name
      t.string  :last_name
      t.string  :password_digest
      t.string  :uid
      t.string  :token
      t.string :provider
      t.string  :username
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
