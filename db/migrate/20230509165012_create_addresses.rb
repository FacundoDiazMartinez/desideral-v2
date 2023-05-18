class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :country, null: false, default: "Argentina"
      t.string :state, null: false, default: "Buenos Aires"
      t.string :city, null: false, default: "Buenos Aires"
      t.string :street_name, null: false
      t.string :street_number, null: false
      t.string :post_code, null: false
      t.references :addressable, polymorphic: true
      t.boolean :available, null: false, default: true

      t.timestamps
    end

    add_index :addresses, [:addressable_id, :addressable_type, :available], unique: true, where: "available", name: "index_addresses_on_addressable_and_available"
  end
end
