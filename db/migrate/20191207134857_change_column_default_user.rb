class ChangeColumnDefaultUser < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :bgcolor, '#005a55'
  end
end
