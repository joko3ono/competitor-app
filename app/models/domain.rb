class Domain < ApplicationRecord
  MAX_COMPETITORS = 2

  has_many :competitors
end

# == Schema Information
#
# Table name: domains
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
