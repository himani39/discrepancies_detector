require_relative '../../lib/services/discrepancies_detector'

describe DiscrepanciesDetector do

  describe '#call' do

    subject { DiscrepanciesDetector.call }

    context "when local and remote campaigns are in sync" do
      before do
        allow_any_instance_of(DiscrepanciesDetector).to receive(:local_campaigns).and_return([{ reference: "1", status: "enabled", description: "Some description", local: true}])
        allow_any_instance_of(DiscrepanciesDetector).to receive(:remote_campaigns).and_return([{ reference: "1", status: "enabled", description: "Some description"}])
      end

      it "does not return any discrepancy" do
        expect(subject.length).to eq(0)
      end
    end

    context "when local and remote campaigns are not in sync" do
      before do
        allow_any_instance_of(DiscrepanciesDetector).to receive(:local_campaigns).and_return([{ reference: "1", status: "enabled", description: "Some description", local: true}])
        allow_any_instance_of(DiscrepanciesDetector).to receive(:remote_campaigns).and_return([{ reference: "1", status: "disabled", description: "Some description"}])
      end

      it "returns the discrepancy" do
        expect(subject.length).to eq(1)
        expect(subject.first.keys).to eq([:remote_reference, :discrepancies])
        expect(subject.first[:discrepancies]).to eq({"status"=>{:local=>"enabled", :remote=>"disabled"}})
      end
    end

    context "when a remote campaign is not added to local campaigns" do
      before do
        allow_any_instance_of(DiscrepanciesDetector).to receive(:local_campaigns).and_return([])
        allow_any_instance_of(DiscrepanciesDetector).to receive(:remote_campaigns).and_return([{ reference: "1", status: "disabled", description: "Some description"}])
      end

      it "returns the discrepancy" do
        expect(subject.length).to eq(1)
        expect(subject.first.keys).to eq([:remote_reference, :discrepancies])
        expect(subject.first[:discrepancies]).to eq({"description"=>{:local=>nil, :remote=>"Some description"}, "status"=>{:local=>nil, :remote=>"disabled"}})
      end
    end
  end

  describe '#discrepancies' do

    subject { DiscrepanciesDetector.new().send(:discrepancies, local_campaign, remote_campaign) }

    context "when status does not match" do
      let(:local_campaign) { {status: "enabled", description: "Some description"} }
      let(:remote_campaign) { {status: "disabled", description: "Some description"} }
      it "returns the local and remote status" do
        expect(subject["status"]).to eq({"local": "enabled", "remote": "disabled"})
      end
    end

    context "when description does not match" do
      let(:local_campaign) { {status: "enabled",description: "Some description"} }
      let(:remote_campaign) { {status: "enabled",description: "Some other description"} }
      it "returns the local and remote description" do
        expect(subject["description"]).to eq({"local": "Some description", "remote": "Some other description"})
      end
    end
  end


  describe '#compare' do
    context "when two campaigns are passed" do
      subject { DiscrepanciesDetector.new.send(:compare, "1", [{status: "enabled"}, {status: "disabled"}]) }

      it "compares both the campigns" do
        expect_any_instance_of(DiscrepanciesDetector).to receive(:discrepancies).with({status: "enabled"}, {status: "disabled"})
        expect(subject.keys).to eq([:remote_reference, :discrepancies])
        expect(subject[:remote_reference]).to eq("1")
      end
    end

    context "when only one campaign is passed" do
      subject { DiscrepanciesDetector.new.send(:compare, "1", [{local: true, status: "enabled"}]) }

      it "identifies the campaign as local or remote and compares" do
        expect_any_instance_of(DiscrepanciesDetector).to receive(:discrepancies).with({local: true, status: "enabled"}, {})
        expect(subject.keys).to eq([:remote_reference, :discrepancies])
        expect(subject[:remote_reference]).to eq("1")
      end
    end
  end
end