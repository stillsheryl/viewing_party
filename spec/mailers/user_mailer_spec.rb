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
      expect(mail.text_part.body.to_s).to include('Welcome to ViewingParty.com, Zach')
      expect(mail.text_part.body.to_s).to include("You have successfully signed up to ViewingParty.com")

      expect(mail.html_part.body.to_s).to include('Welcome to ViewingParty.com, Zach')
      expect(mail.html_part.body.to_s).to include("You have successfully signed up to ViewingParty.com")

      expect(mail.body.encoded).to include('Welcome to ViewingParty.com, Zach')
      expect(mail.body.encoded).to include("You have successfully signed up to ViewingParty.com")
    end
  end
end
