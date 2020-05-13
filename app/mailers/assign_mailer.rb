class AssignMailer < ApplicationMailer
   def assign_mail(contact,post)
    @contact = contact
    @post = post
    mail to: @contact.email, subject: "会員登録の確認メール"
  end
end
