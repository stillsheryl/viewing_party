require 'rails_helper'

describe User, type: :model do
  describe "relationships" do
    it { should have_many :guests }
    it { should have_many(:parties).through(:guests) }
    it { should have_many :friendships }
    it { should have_many(:friends).through(:friendships) }
  end

  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password }
  end

  # it 'sends an email' do
  #   user = User.create!(first_name: 'Zach',
  #                        last_name: 'Stearns',
  #                            email: 'zach@email.com',
  #                         password: 'password')
  #
  #   expect { user.welcome_email }
  #     .to change { ActionMailer::Base.deliveries.count }.by(1)
  # end
end
