require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner[:active_record,{:connection => ActiveRecord::RdsDb}].strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
    DatabaseCleaner[:active_record,{:connection => ActiveRecord::RdsDb}].start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    DatabaseCleaner[:active_record,{:connection => ActiveRecord::RdsDb}].clean
  end
end