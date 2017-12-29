class Competitor < ApplicationRecord
  belongs_to :domain
end

# == Schema Information
#
# Table name: competitors
#
#  id         :integer          not null, primary key
#  domain_id  :integer
#  name       :string
#  business   :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
