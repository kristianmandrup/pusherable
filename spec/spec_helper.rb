require 'rubygems'
require 'bundler/setup'
require 'active_record'
require 'database_cleaner'
require 'pusher'

Pusher.app_id = '123456'
Pusher.secret = 'FAKE'
Pusher.key    = 'FAKE'

require 'pusherable'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

load File.dirname(__FILE__) + '/support/schema.rb'
load File.dirname(__FILE__) + '/support/models.rb'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
