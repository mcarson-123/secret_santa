class AddGiftPreferencesToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :gift_preferences, :text, array: true, default: []
  end
end
