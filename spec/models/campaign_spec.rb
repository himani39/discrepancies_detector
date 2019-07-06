require_relative '../../lib/models/campaign'

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
end