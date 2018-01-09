class Competitor < ApplicationRecord
  belongs_to :domain

  validates :name,
            presence: true,
            uniqueness: {
              scope: :domain,
              message: "Oops. There is another competitor with this website already."
            }
  validates :business,
            presence: true,
            uniqueness: {
              scope: :domain,
              message: "Oops. There is another competitor with this label already."
            }
  validates :domain_id, numericality: { only_integer: true }
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
