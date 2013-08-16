class Link < ActiveRecord::Base
  attr_accessible :title, :body, :url, :author_id, :sub_id

  validates :title, :url, :author_id, :sub_id, presence: true

  belongs_to :author,
  class_name: 'User',
  foreign_key: :author_id,
  primary_key: :id

  has_many :sub_links,
  class_name: 'SubLink',
  foreign_key: :link_id,
  primary_key: :id
end
