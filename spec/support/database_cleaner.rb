# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.allow_remote_database_url = true
    DatabaseCleaner.url_allowlist = [ENV["DATABASE_URL"]]

    DatabaseCleaner.clean_with :truncation, except: %w(ar_internal_metadata)
  end

  config.before do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :system) do
    # Driver is probably for an external browser with an app
    # under test that does *not* share a database connection with the
    # specs, so use truncation strategy.
    DatabaseCleaner.strategy = :truncation
  end

  config.before do
    DatabaseCleaner.start
  end

  config.append_after do
    DatabaseCleaner.clean
  end
end
