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

require 'rails_helper'

RSpec.describe Participant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
