if Rails.env.production? || Rails.env.staging?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_PROVIDER'] }

    database_url = ENV['DATABASE_URL']
    if database_url
      ENV['DATABASE_URL'] = "#{database_url}?pool=25"
      ActiveRecord::Base.establish_connection
    end
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_PROVIDER'] }
  end
end
