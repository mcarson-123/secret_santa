class AddGiftOptionsToParty < ActiveRecord::Migration
  def change
    add_column :parties, :gift_options, :text, array: true, default: []
  end
end
