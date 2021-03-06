class Choice < ActiveRecord::Base
  attr_accessible :response_text, :question_id

  belongs_to  :question,
              :class_name  => 'Question',
              :foreign_key => :question_id,
              :primary_key => :id

  has_many  :responses,
            :class_name  => 'Response',
            :foreign_key => :choice_id,
            :primary_key => :id
end
