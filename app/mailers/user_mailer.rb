class UserMailer < ApplicationMailer

  def welcome_email(info, recipient)
    @user = info[:user]
    @url = 'https://viewing-party-13.herokuapp.com'

    mail(
      to: recipient,
      subject: "Welcome to Viewing Party, #{@user.first_name}!"
    )
  end
end
