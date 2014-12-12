require 'securerandom'

class SandboxEmailInterceptor
  def self.delivering_email(message)

    message.subject = "#{message.subject} - [#{SecureRandom.hex(5)}]" unless Rails.env.production?

    if Rails.env.test? || Rails.env.development?
      message.to = "dennismonsewicz@gmail.com"
    elsif Rails.env.staging?
      message.to = "tom@tomhaarlander.com"
    end
  end
end

ActionMailer::Base.register_interceptor(SandboxEmailInterceptor) unless Rails.env.production?
