class Poll < ActiveRecord::Base
  attr_accessible :title, :author_id
end
