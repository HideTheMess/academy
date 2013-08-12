class Band < ActiveRecord::Base
  attr_accessible :name

  has_many :albums,
  class_name: 'Album',
  foreign_key: :band_id,
  primary_key: :id,
  dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
