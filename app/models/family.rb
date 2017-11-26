# == Schema Information
#
# Table name: families
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Family < ActiveRecord::Base

  #
  # Families are used to denote groups of participants
  # who should not be paried with each other for giftings
  #

  #---------------------------------------------------------------------
  # Associations
  #---------------------------------------------------------------------

  has_many :participants

  #---------------------------------------------------------------------
  # Instance Methods
  #---------------------------------------------------------------------

  def size
    return participants.count
  end

end
