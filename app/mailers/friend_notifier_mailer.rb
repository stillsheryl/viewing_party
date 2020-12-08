class FriendNotifierMailer < ApplicationMailer
  def inform(info, recipient)
    @user = info[:user]
    # @message = info[:message]
    @friend = info[:friend]

    mail(
      reply_to: @user.email,
      to: recipient,
      subject: "#{@user.name} is sending you some advice"
    )
  end
end
