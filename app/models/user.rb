class User < ActiveRecord::Base
#relationship with model Entry
# dependent: :destroy arranges for the dependent entries to be destroyed when the user itself is destroyed
has_many :entries, dependent: :destroy
# dependent: :destroy arranges for the dependent comment to be destroyed when the user itself is destroyed
has_many :comments, dependent: :destroy
#make the relationship  betwwen user by using follwer as key
has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
#make the relationship  betwwen user by using follwer as key
has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
#make a relationships for following
has_many :following, through: :active_relationships, source: :followed
#make a relationships for following
has_many :followers, through: :passive_relationships, source: :follower
#user before_save callback to downcase user email before saving
#Callbacks
before_save{email.downcase!}
#before_create :create_activation_digest
#name
validates :name,  presence: true, 
                    length: { maximum: 50 }
#email
VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
validates :email, presence:   true, 
                    length:     { maximum: 255 }, 
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
#password
has_secure_password  
validates :password, length:  { minimum: 6 }, allow_blank: true

# define method to return the hash digest of the given string
def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)   
end
#define feed for user entry
def feed
	Entry.from_users_followed_by(self)
end
# Follow a user
def  follow(other_user)
	active_relationships.create(followed_id: other_user.id)
end
#unfollow a user
def unfollow(other_user)
	active_relationships.find_by(followed_id: other_user.id).destroy
end
#return true if the current user is following the other user.
def following?(other_user)
	following.include?(other_user)
end
end
