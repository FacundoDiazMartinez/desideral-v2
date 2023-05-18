class RemoveLogoFromCompanies < ActiveRecord::Migration[7.0]
  def change
    remove_column :companies, :logo, :string
  end
end
