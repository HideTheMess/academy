class Favorite < ActiveRecord::Base
  attr_accessible :gist_id, :user_id
end
