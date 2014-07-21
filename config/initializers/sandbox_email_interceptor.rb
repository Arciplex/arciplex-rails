class SandboxEmailInterceptor
  def self.delivering_email(message)
    message.to = "dennismonsewicz@gmail.com"
  end
end

ActionMailer::Base.register_interceptor(SandboxEmailInterceptor) if Rails.env.development? || Rails.env.test?
