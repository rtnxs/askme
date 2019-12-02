class AddUniqIndexUsernameEmailToUser < ActiveRecord::Migration[6.0]
  def change
    add_index :users, [:username, :email], unique: true
  end
end
