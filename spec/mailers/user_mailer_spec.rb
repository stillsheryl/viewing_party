require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

describe "when a user signs up for a new account" do
  # it "send a welcome email" do

      # user = User.create!(first_name: 'Shelly',
      #   last_name: 'Waters',
      #   email: 'shelly1@email.com',
      #   password: 'password')
      # email = UserMailer.welcome_email('no_reply@viewingparty.com', 'user@example.com', Time.now)

    # Send the email, then test that it got queued
      # assert_emails 1 do
      #   email.deliver_now
      # end

      # Test the body of the sent email contains what we expect it to
      # assert_equal ['no_reply@viewingparty.com'], email.from
      # assert_equal ['user@example.com'], email.to
      # assert_equal 'Welcome to Viewing Party!', email.subject
      # assert_equal read_fixture('invite').join, email.body.to_s


    # let(:mail) { UserMailer.welcome_email.deliver_now }

    xit "renders the headers" do
      expect(mail.subject).to eq("Welcome to Viewing Party!")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["no_reply@viewingparty.com"])
    end

    xit "renders the body" do
      expect(mail.body.encoded).to match("Welcome to ViewingParty.com")
    end

    # end
  end
end
