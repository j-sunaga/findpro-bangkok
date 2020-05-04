class SignupMailer < ApplicationMailer
   def signup_mail(contact)
    @contact = contact
    mail to: "s-test@example.com", subject: "会員登録の確認メール"
  end
end
