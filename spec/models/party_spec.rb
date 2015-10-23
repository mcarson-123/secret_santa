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

require 'rails_helper'

RSpec.describe Party, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
