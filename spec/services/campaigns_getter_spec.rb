require_relative '../../lib/services/campaigns_getter'
require_relative '../../lib/models/campaign'
require_relative '../spec_helper'

describe CampaignsGetter do
  before do
    FactoryBot.create(:campaign)
    FactoryBot.create(:campaign)
  end

  describe '#call' do
    subject { CampaignsGetter.call }
    it "gets all the campaigns" do
      expect(subject).to be_an_instance_of(Array)
      expect(subject.length).to eq(2)
    end
  end
end