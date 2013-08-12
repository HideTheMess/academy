class Track < ActiveRecord::Base
  attr_accessible :name, :album_id, :track_type, :lyrics

  belongs_to :album,
  class_name: 'Album',
  foreign_key: :album_id,
  primary_key: :id

  has_many :notes,
  class_name: 'Note',
  foreign_key: :track_id,
  primary_key: :id,
  dependent: :destroy

  validates :name, :album_id, :track_type, :lyrics, presence: true
end
