class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false, index: {unique: true}
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
