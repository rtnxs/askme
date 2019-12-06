class AddBgcolorToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :bgcolor, :string, default: '#0055a55'
  end
end
