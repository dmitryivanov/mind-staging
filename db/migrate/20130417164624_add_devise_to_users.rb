class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :password_digest, :encrypted_password
    add_index     :users, :email, unique: true
  end

  def self.down
    rename_column :users, :encrypted_password, :password_digest
    remove_index  :users, :email
  end
end
