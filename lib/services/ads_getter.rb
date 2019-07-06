
class AdsGetter
  include Callable
  require 'httparty'

  def call
    response = HTTParty.get(ad_service_url)
    response.parsed_response["ads"]
  end

  private

  def ad_service_url
    "https://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df"
  end
end