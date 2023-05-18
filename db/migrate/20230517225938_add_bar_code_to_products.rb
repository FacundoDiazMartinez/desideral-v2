class AddBarCodeToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :code, :string, null: false, default: ""
    add_column :products, :model, :string, null: false, default: ""
  end
end
