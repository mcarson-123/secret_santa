class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name
      t.timestamps null: false
    end

    add_column :participants, :family_id, :integer
  end
end
