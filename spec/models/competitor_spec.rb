# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Competitor, type: :model do
  let(:domain) { FactoryBot.create(:domain) }
  let!(:competitor) { FactoryBot.create(:competitor, domain: domain) }

  describe 'formating and position' do
    before do
      @competitor = FactoryBot.create(:competitor,
                                      domain: domain,
                                      position: nil,
                                      name: 'http://www.doodle.com',
                                      business: 'random business')
    end

    it 'when create new competitor should give auto number to position' do
      expect(@competitor.position).to eq(2)
    end

    it 'when destroy competitor should reduce other competitor position to 1' do
      expect(@competitor.reload.position).to eq(2)
      competitor.destroy
      expect(@competitor.reload.position).to eq(1)
    end
  end

  describe 'validation' do
    it 'should validate required field' do
      expect(competitor.update_attributes(name: '')).to be_falsey
      expect(competitor.update_attributes(business: '')).to be_falsey
      expect(competitor.update_attributes(domain: nil)).to be_falsey
    end

    it 'should only accept valid TLD' do
      expect(competitor.update_attributes(name: 'www.domain.clo')).to be_falsey
      expect(competitor.errors.messages[:name]).to eq([I18n.t('activerecord.errors.models.competitor.attributes.name.url_not_valid')])
    end

    it 'should not similar with domain name' do
      expect(competitor.update_attributes(name: domain.name.upcase)).to be_falsey
      expect(competitor.errors.messages[:name]).to eq([I18n.t('activerecord.errors.models.competitor.attributes.name.url_not_self_domain')])
    end
  end
end
