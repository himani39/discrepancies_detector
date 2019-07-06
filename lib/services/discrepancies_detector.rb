class DiscrepanciesDetector
  include Callable

  def call
    (local_campaigns + remote_campaigns)
      .group_by { |campaign| campaign[:reference] }
      .map { |reference, comparable_campaigns| compare(reference, comparable_campaigns) }
      .select { |compared_result| compared_result[:discrepancies].present? }
  end

  private

  def local_campaigns
    @local_campaigns ||= CampaignsGetter.call
  end

  def remote_campaigns
    @remote_campaigns ||= AdsGetter.call
  end

  def compare(reference, campaigns)
    if (campaigns.length == 1) {
      campaigns = campaigns.first[:local] ? [campaigns.first, {}] : [{}, campaigns.first]
    }

    {
      remote_reference: reference,
      discrepancies: discrepancies(*campaigns)
    }
  end

  def discrepancies(local_campaign, remote_campaign)
    discrepancies = {}
    discrepancies["status"] = { "local": local_campaign[:status], "remote": remote_campaign[:status] } unless status_matches?(local_campaign, remote_campaign)
    discrepancies["description"] = { "local": local_campaign[:ad_description], "remote": remote_campaign[:description] } unless description_matches?(local_campaign, remote_campaign)
    discrepancies
  end


  def status_matches?(local_campaign, remote_campaign)
    local_campaign[:status] == remote_campaign[:status]
  end

  def description_matches?(local_campaign, remote_campaign)
    local_campaign[:description] == remote_campaign[:description]
  end
end