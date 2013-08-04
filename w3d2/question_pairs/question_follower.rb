require './question_database'
require './user'
require './question'

class QuestionFollower
  attr_reader :id, :user_id, :question_id

  def initialize(follower_hash)
    @id = follower_hash['id']
    @user_id = follower_hash['user_id']
    @question_id = follower_hash['question_id']
  end

  def self.find_by_id(id)
    question_follower = QuestionDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_followers
      WHERE id = ?
    SQL

    QuestionFollower.new(question_follower[0])
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionDatabase.instance.execute(<<-SQL, user_id)
      SELECT questions.*
      FROM questions
      JOIN question_followers ON questions.id = quesion_followers.question_id
      WHERE question_followers.user_id = ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  def self.followers_for_question_id(quesion_id)
    users = QuestionDatabase.instance.execute(<<-SQL, question_id)
      SELECT users.*
      FROM users
      JOIN question_followers ON users.id = quesion_followers.user_id
      WHERE question_followers.question_id = ?
    SQL

    users.map { |user| User.new(user) }
  end

  def self.most_followed_questions(n)
    questions = QuestionDatabase.instance.execute(<<-SQL)
      SELECT questions.*
      FROM questions
      JOIN question_followers ON questions.id = quesion_followers.question_id
      GROUP BY question_followers.question_id
      ORDER BY COUNT(question_followers.user_id) DESC
    SQL

    ranked_questions = questions.map { |question| Question.new(question) }
    ranked_questions.take(n)
  end
end
