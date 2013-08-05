class Poll < ActiveRecord::Base
  attr_accessible :title, :author_id

  belongs_to  :author,
              :class_name  => 'User',
              :foreign_key => :author_id,
              :primary_key => :id

  has_many  :questions,
            :class_name  => 'Question',
            :foreign_key => :poll_id,
            :primary_key => :id

  def results
    results = {}

    responses_counts = Choice
      .select("questions.prompt, choices.response_text,
        COUNT(responses.id) AS response_count")
      .joins("LEFT JOIN responses ON responses.choice_id = choices.id")
      .joins("LEFT JOIN questions ON choices.question_id = questions.id")
      .where("questions.poll_id" => self.id)
      .group("choices.id")

      responses_counts.each do |response_count|
        results[response_count.prompt] =
          { response_count.response_text => response_count.response_count }
      end

    results
  end
end
