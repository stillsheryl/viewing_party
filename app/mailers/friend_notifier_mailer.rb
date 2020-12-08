class FriendNotifierMailer < ApplicationMailer
  def inform(info, recipient)
    @user = info[:user]
    @friend = info[:friend]

    mail(
      reply_to: @user.email,
      to: recipient,
      subject: "#{@user.first_name} has added you as a friend on ViewingParty!"
    )
  end
end
