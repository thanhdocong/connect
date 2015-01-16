class Entry < ActiveRecord::Base
  # dependent: :destroy arranges for the dependent comment to be destroyed when the user itself is destroyed
  has_many :comments, dependent: :destroy
  #add relationship to model user
  belongs_to :user
  #set default by order
  default_scope -> { order('created_at DESC') }
  #Add picture when post entry
  #mount_uploader :picture, PictureUploader
  #must have user_id can =nil in field
  validates :user_id, presence: true
  #must be valid title and have length limit 140
  validates :title, presence: true, length:{maximum:140}
  #must have valid body and have length limit 500
  validates :body, presence: true, length:{maximum:500}
  #should valid with image size
  #validate :picture_size

  def Entry.from_users_followed_by (user)
    ##declare follow ids and init from user following ids
    #following_ids=user.following_ids
    ##find and return by replacing into string 
    #where("user_id IN (:following_ids) OR user_id= :user_id", following_ids: following_ids,user_id: user)
    
    #declare follow ids and init from sql select from table relationship
    following_ids = "SELECT followed_id FROM relationships WHERE  follower_id = :user_id"
    ##find and return by replacing into string aql 
    where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: user)
  end
  #private part
  private
  #define method to check size of image
  def picture_size
    #check if size of image is biger than 5 MB
    if picture.size > 5.megabytes
      #add error when user post entry
      errors.add(:picture," should be less tha 5MB")
    end
  end
end
