require_relative '../../lib/services/ads_getter'

describe AdsGetter do
  describe '#call' do
    subject { AdsGetter.call }
    it "gets all the ads from ad service" do
      allow(HTTParty).to receive(:get).and_return(double('Response', :parsed_response => { ads: [ { "reference": "1", "status": "enabled", "description": "Description for campaign 11" }, { "reference": "2", "status": "disabled", "description": "Description for campaign 12" } ] }))

      expect(subject).to be_an_instance_of(Array)
      expect(subject.length).to eq(2)
    end
  end
end