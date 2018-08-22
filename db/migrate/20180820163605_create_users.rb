class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :phone_number
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
