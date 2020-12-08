class UserMailer < ApplicationMailer
  default from: 'no_reply@viewingparty.com'

  def welcome_email(info, recipient)
    @user = info[:user]
    @url = 'https://viewing-party-13.herokuapp.com/registration'

    mail(
      to: recipient,
      subject: "Welcome to Viewing Party, #{@user.name}!"
    )
  end
end
