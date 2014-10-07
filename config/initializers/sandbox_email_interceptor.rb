class SandboxEmailInterceptor
  def self.delivering_email(message)
    if Rails.env.test? || Rails.env.development?
      message.to = "dennismonsewicz@gmail.com"
    elsif Rails.env.staging?
      message.to = "info@arciplex.com"
    end
  end
end

ActionMailer::Base.register_interceptor(SandboxEmailInterceptor) unless Rails.env.production?
