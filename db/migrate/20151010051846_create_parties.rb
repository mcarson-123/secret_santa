class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :name
      t.string :passphrase
      t.integer :spending_limit
      t.string :theme
      t.timestamps null: false
    end
  end
end
