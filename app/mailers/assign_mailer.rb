class AssignMailer < ApplicationMailer
  def assign_mail(contact, post)
    @contact = contact
    @post = post
    mail to: '124577blue@gmail.com', subject: 'You are selected!'
  end
end
