class AddAttributesToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :iva_status, :integer, null: false, default: 0
    add_column :companies, :id_number, :string
    add_column :companies, :business_name, :string
    add_column :companies, :phone_number, :string
    add_column :companies, :email, :string
    add_column :companies, :logo, :string, null: false, default: "/images/default_logo.png"

    add_index :companies, [:available, :email], unique: true, where: "available"
    add_index :companies, [:available, :id_number], unique: true, where: "available"
  end
end
