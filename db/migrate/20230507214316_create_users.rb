class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false, limit: 100
      t.string :last_name,  null: false, limit: 100
      t.string :password_digest, null: false
      t.string :avatar, null: false, default: '/images/default_avatar.png'
      t.string :email, null: false, limit: 100, unique: true, index: true

      t.timestamps
    end
  end
end
