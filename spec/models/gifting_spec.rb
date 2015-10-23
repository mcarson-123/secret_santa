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

require 'rails_helper'

RSpec.describe Gifting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
