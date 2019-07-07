require_relative '../../lib/models/campaign'
require_relative '../spec_helper'

describe Campaign do
  describe '#details' do
    let(:campaign) { FactoryBot.build(:campaign, external_reference: "1", status: "active", ad_description: "Description here") }
    subject { campaign.details }
    it "returns details" do
      expect(subject.keys).to eq([:reference, :local, :description, :status])
      expect(subject[:local]).to eq(true)
      expect(subject[:reference]).to eq("1")
      expect(subject[:status]).to eq("enabled")
      expect(subject[:description]).to eq("Description here")
    end
  end

  describe '#ad_status' do
    it "returns appropriate ad-status" do
      expect(FactoryBot.build(:campaign, status: "active").send(:ad_status)).to eq("enabled")
      expect(FactoryBot.build(:campaign, status: "paused").send(:ad_status)).to eq("disabled")
      expect(FactoryBot.build(:campaign, status: "deleted").send(:ad_status)).to eq("deleted")
    end
  end
end