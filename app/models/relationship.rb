class Relationship < ActiveRecord::Base
	#define a relationships between each user
	#user user follow other
	belongs_to :follower, class_name: "User"
	#user who other user follow
	belongs_to :followed, class_name: "User"
	#make sure that follower id is valid
	validates :follower_id, presence: true
	validates :followed_id, presence: true
end
