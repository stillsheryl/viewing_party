require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe "relationships" do
    it { should belong_to :user }
    it { should belong_to(:friend).class_name('User') }
  end

  xit 'sends an email when a friendship is created' do
    user1 = User.create!(first_name: 'Zach',
                         last_name: 'Stearns',
                             email: 'zach@email.com',
                          password: 'password')
    user2 = User.create!(first_name: 'Angelina',
                            last_name: 'Jolie',
                            email: 'angie@email.com',
                            password: 'tombraider')

    info = {
      user: user1,
      friend: user2.first_name,
    }
    recipient = user2.email

    expect { FriendNotifierMailer.inform(info, recipient) }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
