require 'database_cleaner'
require 'factory_bot'

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

end

# RSpec.configure do |config|
#   config.include FactoryBot::Syntax::Methods
# end

FactoryBot.define do
  factory :campaign
end