class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string :url, null: false
      t.references :company, null: false, foreign_key: true
      t.boolean :available, null: false, default: true
      t.bigint :imageable_id, null: false
      t.string :imageable_type, null: false

      t.timestamps
    end

    add_index :images, [:imageable_id, :imageable_type, :available], unique: true, where: "available"
  end
end
