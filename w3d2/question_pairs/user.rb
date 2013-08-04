require './question_database'
require './question'
require './reply'
require './question_follower'
require './question_like'

class User
  attr_reader :id, :fname, :lname

  def initialize(user_hash)
    @id = user_hash['id']
    @fname, @lname = user_hash['fname'], user_hash['lname']
  end

  def self.find_by_id(id)
    user = QuestionDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM users
      WHERE id = ?
    SQL

    User.new(user[0])
  end

  def self.find_by_name(fname, lname)
    user = QuestionDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT *
      FROM users
      WHERE fname = ?
      AND lname = ?
    SQL

    User.new(user[0])
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def average_karma
    user_questions = Question.find_by_author_id(@id)
    question_ids = user_questions.map { |question| question.id }

    questions_count = question_ids.size
    total_likes = question_ids.inject(0) do |sum, question_id|
      sum + QuestionLike.num_likes_for_question_id(question_id)
    end

    total_likes / questions_count
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def save
    if @id.nil?
      QuestionDatabase.instance.execute(<<-SQL, @fname, @lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?);
      SQL

      self = User.new(User.find_by_name(@fname, @lname))
    else
      QuestionDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
        UPDATE users
        SET fname = ?, lname = ?
        WHERE id = ?;
      SQL
  end
end
