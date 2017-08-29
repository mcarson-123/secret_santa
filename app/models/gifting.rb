# == Schema Information
#
# Table name: giftings
#
#  id             :integer          not null, primary key
#  participant_id :integer
#  giftee_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  confirm_token  :string
#  state          :integer          default(0)
#

class Gifting < ActiveRecord::Base
  include ObfuscateIds

  #---------------------------------------------------------------------
  # Associations
  #---------------------------------------------------------------------

  belongs_to :participant
  belongs_to :giftee, class_name: "Participant"

  delegate :party, to: :participant

  #-----------------------------------------------------------------------------
  # Enums
  #-----------------------------------------------------------------------------

  enum state: [:created, :confirmed]

  #-----------------------------------------------------------------------------
  # Callbacks
  #-----------------------------------------------------------------------------

  before_create :generate_token

  private

  def generate_token
    token = loop do
      random_token = SecureRandom.hex(8)
      break random_token unless self.class.find_by(confirm_token: random_token)
    end
    self.confirm_token = token
  end

end
