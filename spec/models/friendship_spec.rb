require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe "relationships" do
    it { should belong_to :user }
    it { should belong_to(:friend).class_name('User') }
  end

  it 'sends an email when a friendship is created' do
    user1 = User.create!(first_name: 'Zach',
                         last_name: 'Stearns',
                             email: 'zach@email.com',
                          password: 'password')
    user2 = User.create!(first_name: 'Angelina',
                            last_name: 'Jolie',
                            email: 'angie@email.com',
                            password: 'tombraider')

    Friendship.create!(user_id: user1.id, friend_id: user2.id)


    # mail = mock(mail)
    # mail.should_receive(:deliver)
    # FriendNotifierMailer.should_receive(:inform).once.and_return(mail)

    expect { FriendNotifierMailer.inform }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
