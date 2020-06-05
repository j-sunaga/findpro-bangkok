class AssignMailer < ApplicationMailer
  def assign_mail(contact, post)
    @contact = contact
    @post = post
    mail to: @contact.email, subject: 'You are selected!'
  end
end
