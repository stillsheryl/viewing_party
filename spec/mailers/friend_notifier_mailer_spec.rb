require 'rails_helper'

RSpec.describe FriendNotifierMailer, type: :mailer do

  describe 'inform' do
    before :each do
      sending_user = User.create!(
        first_name: 'Zach',
        last_name: 'Stearns',
        email: 'zach@email.com',
        password: 'thebestjedi'
      )

      @email_info = {
        user: sending_user,
        friend: 'Angelina',
        message: 'Work through your anger with exercise, and wear a mask'
      }

    end

    let(:mail) { FriendNotifierMailer.inform(@email_info, 'angie@email.com') }

    it 'renders the headers' do
      expect(mail.subject).to eq('Zach has added you as a friend on ViewingParty!')
      expect(mail.to).to eq(['angie@email.com'])
      expect(mail.from).to eq(['no_reply@viewingparty.com'])
      expect(mail.reply_to).to eq(['zach@email.com'])
    end

    it 'renders the body' do
      expect(mail.text_part.body.to_s).to include('Hello Angelina')
      expect(mail.text_part.body.to_s).to include("I've added you as a freind on Viewing Party.com!")

      expect(mail.html_part.body.to_s).to include('Hello Angelina')
      expect(mail.html_part.body.to_s).to include("I've added you as a freind on Viewing Party.com!")

      expect(mail.body.encoded).to include('Hello Angelina')
      expect(mail.body.encoded).to include("I've added you as a freind on Viewing Party.com!")
    end
  end
end
