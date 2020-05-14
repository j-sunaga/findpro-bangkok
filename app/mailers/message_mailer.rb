class MessageMailer < ApplicationMailer
   def message_mail(recipient,message)
    @message = message
    mail to: recipient.email, subject: "new message receive"
  end
end
