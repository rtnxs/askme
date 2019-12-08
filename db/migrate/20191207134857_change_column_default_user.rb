class ChangeColumnDefaultUser < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      change_column_default :users, :bgcolor, '#005a55'
    end
  end
end
