require_relative 'concerns/callable'
require_relative '../models/campaign'

class CampaignsGetter
  include Callable

  def call
    Campaign.all.map(&:details)
  end
end