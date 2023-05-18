class AddNameIndexToCompanies < ActiveRecord::Migration[7.0]
  def change
    remove_index :companies, :name
    add_index :companies, [:name, :available], unique: true, where: "available"
  end
end
