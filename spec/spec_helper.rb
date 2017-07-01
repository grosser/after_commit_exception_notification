require "after_commit_exception_notification/version"
require "after_commit_exception_notification"

# connect
ActiveRecord::Schema.verbose = false
ActiveRecord::Base.establish_connection(
  adapter: "mysql2",
  database: "after_commit_exception_notification",
  host: "127.0.0.1"
)

# create tables
ActiveRecord::Schema.define(version: 1) do
  create_table :users, force: true
end

# create models
class User < ActiveRecord::Base
  attr_accessor :boom
  after_commit :foo

  def foo
    raise "BOOOM" if boom
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :should
  end
  config.mock_with :rspec do |c|
    c.syntax = :should
  end
end
