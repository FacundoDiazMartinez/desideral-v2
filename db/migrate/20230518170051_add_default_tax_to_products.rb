class AddDefaultTaxToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :default_tax, :decimal, precision: 5, scale: 2, default: 21.0
  end
end
