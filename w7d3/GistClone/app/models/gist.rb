class Gist < ActiveRecord::Base
  attr_accessible :owner_id, :title

  has_many :favorites
end
