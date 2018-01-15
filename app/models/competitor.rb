# frozen_string_literal: true

#
class Competitor < ApplicationRecord
  belongs_to :domain

  delegate :name, to: :domain, prefix: true, allow_nil: true

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
  validate :name_cannot_similar_with_domain_name
  validate :name_should_have_valid_tld

  before_save :fix_position
  before_validation :format
  after_destroy :fix_other_record_position

  private

  def format
    self.name = name.sub(%r{^https?\:\/\/}, '').split('/')[0] if name
  end

  def fix_other_record_position
    other = self.class.where(domain_id: domain_id).first
    other.fix_position.save if other
  end

  ##
  # compare name and domain name with case insensitive using casecmp
  # https://apidock.com/ruby/String/casecmp
  def name_cannot_similar_with_domain_name
    errors.add(:name, :url_not_self_domain) if name && name.casecmp(domain_name).zero?
  end

  ##
  # Validates that the domain name has a valid TLD
  # the regex moved to config/initializers/enum.rb
  #
  # Complex TLD regex validation
  # Used the following document to generate regex
  # http://data.iana.org/TLD/tlds-alpha-by-domain.txt
  #
  def name_should_have_valid_tld
    if name
      tld = name&.match(/(\.[^.\s]+)$/)
      if tld
        correct_tld = tld[1].match(Enum::Competitor::COMMON_TLD_REGEX)
        correct_tld = tld[1].match(Enum::Competitor::COMPLEX_TLD_REGEX) unless correct_tld

        errors.add(:name, :url_not_valid) unless correct_tld
      else
        # considering that a name without a tld is invalid
        # errors.add(:base, t('model_custom.invalid_url'))
        errors.add(:name, :url_not_valid)
      end
    end
  end

  protected

  ##
  # when competitors:
  #   - length 1 and position == 1 just let it be
  #   - length 1 and position == 2 just let it be
  #   - length 0 and position == nil set position to 1
  #   - length 0 and position == 2 set position to 1
  def fix_position
    index = self.class.where(
      'domain_id = :domain_id AND id != :id',
      domain_id: domain_id,
      id: id || 0 # new record it will giving nil, which is always return all records
    ).length

    self.position = index + 1 if valid? && [2, nil].include?(position)
    self
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
