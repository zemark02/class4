class AddPassToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :pass, :string
  end
end
