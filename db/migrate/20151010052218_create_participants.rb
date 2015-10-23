class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.references :party
      t.string :name
      t.string :email
      t.boolean :party_owner
      t.timestamps null: false
    end
  end
end
