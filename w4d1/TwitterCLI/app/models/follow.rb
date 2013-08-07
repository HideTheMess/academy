class Follow < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :follower,
  :class_name  => 'User',
  :foreign_key => :follower_user_id,
  :primary_key => :id

  belongs_to :followee,
  :class_name  => 'User',
  :foreign_key => :followed_user_id,
  :primary_key => :id
end
