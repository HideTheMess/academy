class LinkSub < ActiveRecord::Base
  attr_accessible :sub_id, :link_id

  validates :sub_id, :link_id, presence: true
  validates :sub_id, uniqueness: { scope: :link_id, message: 'Already in Sub' }

  belongs_to :sub,
  class_name: 'Sub',
  foreign_key: :sub_id,
  primary_key: :id

  belongs_to :link,
  class_name: 'Link',
  foreign_key: :link_id,
  primary_key: :id
end
