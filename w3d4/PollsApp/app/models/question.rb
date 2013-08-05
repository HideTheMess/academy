class Question < ActiveRecord::Base
  attr_accessible :prompt, :poll_id

  belongs_to  :poll,
              :class_name  => 'Poll',
              :foreign_key => :poll_id,
              :primary_key => :id

  has_many  :choices,
            :class_name  => 'Choice',
            :foreign_key => :question_id,
            :primary_key => :id

  # has_many  :responses,
#             :through => :choices,
#             :source  => :responses

  def results
    results = {}

    responses_counts = Choice
      .select("choices.response_text, COUNT(responses.id) AS response_count")
      .joins("LEFT JOIN responses ON responses.choice_id = choices.id")
      .joins("LEFT JOIN questions ON choices.question_id = questions.id")
      .where("choices.question_id" => self.id)
      .group("choices.id")

      responses_counts.each do |response_count|
        results[response_count.response_text] = response_count.response_count
      end

    results
  end
end
