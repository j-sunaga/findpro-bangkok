class ApplyMailer < ApplicationMailer
  def apply_mail(apply_user, post)
    @apply_user = apply_user
    @post = post
    mail to: '124577blue@gmail.com', subject: "#{@apply_user.name} applied your post"
  end
end
