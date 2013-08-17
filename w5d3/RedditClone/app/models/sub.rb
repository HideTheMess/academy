class Sub < ActiveRecord::Base
  attr_accessible :name, :mod_id

  validates :name, :mod_id, presence: true

  belongs_to :mod,
  class_name: 'User',
  foreign_key: :mod_id,
  primary_key: :id

  has_many :link_subs,
  class_name: 'LinkSub',
  foreign_key: :sub_id,
  primary_key: :id

  has_many :links,
  through: :link_subs,
  source:  :link

  # accepts_nested_attributes_for :links
end
