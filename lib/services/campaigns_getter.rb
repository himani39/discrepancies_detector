require_relative 'concerns/callable'
require 'byebug'

class CampaignsGetter
  include Callable

  def call
    Campaign.all.map(&:details)
  end
end