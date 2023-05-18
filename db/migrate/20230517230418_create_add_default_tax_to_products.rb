class CreateAddDefaultTaxToProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :add_default_tax_to_products do |t|
      t.integer :default_tax

      t.timestamps
    end
  end
end
