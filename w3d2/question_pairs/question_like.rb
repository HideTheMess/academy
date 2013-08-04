require './question_database'
require './user'
require './question'

class QuestionLike
  attr_reader :id, :user_id, :question_id

  def initialize(like_hash)
    @id = like_hash['id']
    @user_id, @question_id = like_hash['user_id'], like_hash['question_id']
  end

  def self.find_by_id(id)
    question_like = QuestionDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_likes
      WHERE id = ?
    SQL

    User.new(question_like[0])
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionDatabase.instance.execute(<<-SQL, user_id)
      SELECT questions.*
      FROM questions
      JOIN question_likes ON questions.id = quesion_likes.question_id
      WHERE question_likes.user_id = ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  def self.likers_for_question_id(question_id)
    users = QuestionDatabase.instance.execute(<<-SQL, question_id)
      SELECT users.*
      FROM users
      JOIN question_likes ON users.id = quesion_likes.user_id
      WHERE question_likes.question_id = ?
    SQL

    users.map { |user| User.new(user) }
  end

  def self.num_likes_for_question_id(question_id)
    likes_count = QuestionDatabase.instance.execute(<<-SQL, question_id)
      SELECT COUNT(user_id) likes_count
      FROM question_likes
      WHERE question_id = ?
    SQL

    likes_count[0][likes_count]
  end

  def self.most_liked_questions(n)
    questions = QuestionDatabase.instance.execute(<<-SQL)
      SELECT questions.*
      FROM questions
      JOIN question_likes ON questions.id = quesion_likes.question_id
      GROUP BY question_likes.question_id
      ORDER BY COUNT(question_likes.user_id) DESC
    SQL

    ranked_questions = questions.map { |question| Question.new(question) }
    ranked_questions.take(n)
  end
end
