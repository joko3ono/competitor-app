# frozen_string_literal: true

#
class Competitor < ApplicationRecord
  belongs_to :domain

  validates :name,
            presence: true,
            uniqueness: {
              scope: :domain,
              message: 'Oops. There is another competitor with this website already.'
            }
  validates :business,
            presence: true,
            uniqueness: {
              scope: :domain,
              message: 'Oops. There is another competitor with this label already.'
            }

  validates :domain_id, numericality: { only_integer: true }

  before_save :fix_position
  before_validation :format

  private

  def format
    self.name = name.sub(%r{^https?\:\/\/}, '').split('/')[0] if name
  end

  def fix_position
    index = self.class.where('domain_id = ? AND id != ?', domain_id, id || 0).length
    self.position = index + 1 if valid? && [2, nil].include?(position)
  end
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
