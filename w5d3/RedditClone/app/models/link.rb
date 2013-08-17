class Link < ActiveRecord::Base
  attr_accessible :title, :body, :url, :author_id

  validates :title, :url, :author_id, presence: true

  belongs_to :author,
  class_name: 'User',
  foreign_key: :author_id,
  primary_key: :id

  has_many :link_subs,
  class_name: 'LinkSub',
  foreign_key: :link_id,
  primary_key: :id
end
