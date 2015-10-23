class AddConfirmToGiftings < ActiveRecord::Migration
  def change
    add_column :giftings, :confirm_token, :string
    add_column :giftings, :state, :integer, default: 0
  end
end
