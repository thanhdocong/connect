class Comment < ActiveRecord::Base
  belongs_to :entry
  belongs_to :user
  #set default by order
  default_scope -> { order('created_at DESC') }
  #must have user_id cannot =nil in field
  validates :user_id, presence: true
  #must have entry_id cannot =nil in field
  validates :entry_id, presence: true
  #must have valid content and have length limit 200
  validates :content, presence: true, length:{minimum:4,maximum:200}

  
end
