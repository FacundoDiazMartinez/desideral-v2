class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.integer :products_count, default: 0, null: false
      t.references :category, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.boolean :available, default: true, null: false

      t.timestamps
    end

    add_index :categories, [:name, :company_id, :available], unique: true, where: "available"
  end
end
