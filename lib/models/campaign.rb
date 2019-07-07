require 'active_record'

def db_configuration
   db_configuration_file = File.join(File.expand_path('..', __FILE__), '..', '..', 'db', 'config.yml')
   YAML.load(File.read(db_configuration_file))
end

ActiveRecord::Base.establish_connection(db_configuration["development"])

class Campaign < ActiveRecord::Base

  attr_accessor :external_reference, :ad_description, :status

  def details
    {
      reference: external_reference,
      local: true,
      description: ad_description,
      status: ad_status
    }
  end


  private

  def ad_status
    case status
    when "active"
      "enabled"
    when "paused"
      "disabled"
    when "deleted"
      "deleted"
    end
  end
end