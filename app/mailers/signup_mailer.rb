class SignupMailer < ApplicationMailer
  def signup_mail(contact)
    @contact = contact
    mail to: contact.email, subject: 'successfully registered!'
  end
end
