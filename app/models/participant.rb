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
#  family_id        :integer
#

class Participant < ActiveRecord::Base
  include ObfuscateIds

  #---------------------------------------------------------------------
  # Associations
  #---------------------------------------------------------------------

  belongs_to :party
  belongs_to :family
  has_one :gifting
  has_one :giftee, through: :gifting

  #---------------------------------------------------------------------
  # Scopes
  #---------------------------------------------------------------------

  scope :hosts, -> { where(party_owner: true) }
  scope :without_family, -> { where(family: nil) }


  #---------------------------------------------------------------------
  # Instance Methods
  #---------------------------------------------------------------------

  def name_with_possessive_suffix
    suffix = name.ends_with?("s") ? "'" : "'s"
    "#{name}#{suffix}"
  end

end
