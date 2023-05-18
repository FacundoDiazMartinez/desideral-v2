class AddAvailableToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :available, :boolean, default: true, null: false
  end
end
