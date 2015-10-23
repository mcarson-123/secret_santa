class CreateGiftings < ActiveRecord::Migration
  def change
    create_table :giftings do |t|
      t.integer :participant_id
      t.integer :giftee_id
      t.timestamps null: false
    end
  end
end
