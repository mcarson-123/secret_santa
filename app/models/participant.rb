# == Schema Information
#
# Table name: participants
#
#  id               :integer          not null, primary key
#  party_id         :integer
#  name             :string
#  email            :string
#  party_owner      :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  gift_preferences :text             default([]), is an Array
#

class Participant < ActiveRecord::Base

  #---------------------------------------------------------------------
  # Associations
  #---------------------------------------------------------------------

  belongs_to :party
  has_one :gifting
  has_one :giftee, through: :gifting

end
