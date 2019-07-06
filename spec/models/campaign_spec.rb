require_relative '../../lib/models/campaign'
require_relative '../spec_helper'

describe Campaign do
  let(:campaign) { FactoryBot.build(:campaign) }

  describe '#details' do
    subject { campaign.details }
    it "returns details" do
      expect(subject.keys).to eq([:reference, :local, :description, :status])
      expect(subject[:local]).to eq(true)
      expect(subject[:reference]).to eq(campaign.external_reference)
      expect(subject[:status]).to eq(campaign.status)
      expect(subject[:description]).to eq(campaign.ad_description)
    end
  end

  describe '#ad_status' do
    it "returns appropriate ad status" do
      expect(FactoryBot.build(:campaign, status: "active").ad_status).to eq("enabled")
      expect(FactoryBot.build(:campaign, status: "paused").ad_status).to eq("disabled")
      expect(FactoryBot.build(:campaign, status: "deleted").ad_status).to eq("deleted")
    end
  end
end