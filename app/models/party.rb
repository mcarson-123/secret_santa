# == Schema Information
#
# Table name: parties
#
#  id             :integer          not null, primary key
#  name           :string
#  passphrase     :string
#  spending_limit :integer
#  theme          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  gift_options   :text             default([]), is an Array
#

class Party < ActiveRecord::Base
  include HolidayPassphrase
  include ObfuscateIds

  #---------------------------------------------------------------------
  # Associations
  #---------------------------------------------------------------------

  has_many :participants
  has_many :giftings, through: :participants
  has_many :hosts, -> { hosts }, class_name: Participant
  #---------------------------------------------------------------------
  # Callbacks
  #---------------------------------------------------------------------

  before_create :generate_passphrase

  holiday_passphrase :passphrase

end
