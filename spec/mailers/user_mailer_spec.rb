require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

describe "welcome_email" do
      before :each do
        @email_info = {
          user: User.create!(
            first_name: 'Zach',
            last_name: 'Stearns',
            email: 'zach@email.com',
            password: 'thebestjedi'
            ),
          }
      end

    let(:mail) { UserMailer.welcome_email(@email_info, 'zach@email.com') }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome to Viewing Party, Zach!")
      expect(mail.to).to eq(["zach@email.com"])
      expect(mail.from).to eq(["no_reply@viewingparty.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Welcome to ViewingParty.com")
    end
  end
end
