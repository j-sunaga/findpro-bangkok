class MessageMailer < ApplicationMailer
  def message_mail(_recipient, message)
    @message = message
    mail to: '124577blue@gmail.com', subject: 'new message receive'
  end
end
