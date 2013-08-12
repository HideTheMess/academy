class Note < ActiveRecord::Base
  attr_accessible :notes, :track_id

  belongs_to :track,
  class_name: 'Track',
  foreign_key: :track_id,
  primary_key: :id

  validates :notes, :track_id, presence: true
end
