class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false, limit: 100
      t.string :description, null: false, limit: 10000
      t.references :category, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.decimal :price, null: false, default: 0, scale: 2, precision: 10
      t.decimal :stock, null: false, default: 0, scale: 2, precision: 10
      t.integer :unit, null: false, default: 0
      t.boolean :available, null: false, default: true

      t.timestamps
    end

    add_index :products, [:name, :company_id, :available], unique: true, where: "available"
  end
end
