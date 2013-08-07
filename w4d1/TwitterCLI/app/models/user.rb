class User < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many  :statuses,
            :class_name  => 'Status',
            :foreign_key => :author_id,
            :primary_key => :id

  has_many  :inbound_follows,
            :class_name  => 'Follow',
            :foreign_key => :followed_user_id,
            :primary_key => :id

  has_many  :followers,
            :through => :inbound_follows,
            :source  => :follower

  has_many  :outbound_follows,
            :class_name  => 'Follow',
            :foreign_key => :follower_user_id,
            :primary_key => :id

  has_many  :followed_users,
            :through => :outbound_follows,
            :source  => :followee
end
