class SignupMailer < ApplicationMailer
  def signup_mail(contact)
    @contact = contact
    mail to: '124577blue@gmail.com', subject: 'successfully registered!'
  end
end
