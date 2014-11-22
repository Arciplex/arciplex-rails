class ContactMailer < ActionMailer::Base

  def submission(contact)
    @contact = contact
    mail(to: "info@arciplex.com", from: @contact.email, subject: "Message Submission")
  end

end
