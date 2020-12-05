class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :first_name, :last_name
  validates_uniqueness_of :email
  validates_confirmation_of :password

  has_many :guests
  has_many :parties, through: :guests

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :users, foreign_key: :user_id, class_name: "Friendship"
  has_many :friends, through: :users

  has_many :friends, foreign_key: :friend_id , class_name: "Friendship"
  has_many :users, through: :friends
end





# class User < ApplicationRecord
# has_many :followers, foreign_key: :follower_id , class_name: "Friendship"
# has_many :followed, through: :followers
#
# has_many :followed, foreign_key: :followed_id, class_name: "Friendship"
# has_many :followers, through: :followed
# end
#
# class Friendship < ApplicationRecord
# belongs_to :follower, class_name: "User"
# belongs_to :followed, class_name: "User"
# end
#
# class Friendship < ApplicationRecord
#   belongs_to :friend, class_name: "User"
#   belongs_to :user, class_name: "User"
# end
