class CreateTaxes < ActiveRecord::Migration[7.0]
  def change
    create_table :taxes do |t|
      t.string :name, null: false, limit: 50
      t.integer :percentage, null: false, default: 0
      t.bigint :taxeable_id, null: false
      t.string :taxeable_type, null: false
      t.boolean :available, null: false, default: true

      t.timestamps
    end

    add_index :taxes, :name, unique: true
    add_index :taxes, [:taxeable_id, :taxeable_type, :available], unique: true, where: "available"
  end
end
