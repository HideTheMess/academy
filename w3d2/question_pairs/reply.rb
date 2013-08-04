require './question_database'
require './user'
require './question'

class Reply
  attr_reader :id, :reply, :question_id, :parent_id, :user_id

  def initialize(reply_hash)
    @id = reply_hash['id']
    @reply, @question_id = reply_hash['reply'], reply_hash['question_id']
    @parent_id, @user_id = reply_hash['parent_id'], reply_hash['user_id']
  end

  def self.find_by_id(id)
    reply = QuestionDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE id = ?
    SQL

    Reply.new(reply[0])
  end

  def self.find_by_question_id(question_id)
    replies = QuestionDatabase.instance.execute(<<-SQL, question_id)
      SELECT *
      FROM replies
      WHERE question_id = ?
    SQL

    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_user_id(user_id)
    replies = QuestionDatabase.instance.execute(<<-SQL, user_id)
      SELECT *
      FROM replies
      WHERE user_id = ?
    SQL

    replies.map { |reply| Reply.new(reply) }
  end

  def author
    User.find_by_id(@user_id)
  end

  def child_replies
    replies = QuestionDatabase.instance.execute(<<-SQL, @id)
      SELECT *
      FROM replies
      WHERE parent_id = ?
    SQL

    replies.map { |reply| Reply.new(reply) }
  end

  def parent_reply
    return if @parent_id.nil?
    Reply.find_by_id(@parent_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def save
    if @id.nil?
      QuestionDatabase.instance.execute(<<-SQL, @reply, @question_id,
        @parent_id, @user_id)
        INSERT INTO
          replies (reply, question_id, parent_id, user_id)
        VALUES
          (?, ?, ?, ?);
      SQL

      reply = QuestionDatabase.instance.execute(<<-SQL, @reply, @question_id,
        @parent_id, @user_id)
        SELECT *
        FROM questions
        WHERE reply = ?
        AND question_id = ?
        AND parent_id = ?
        AND user_id = ?
      SQL

      self = Reply.new(reply)
    else
      QuestionDatabase.instance.execute(<<-SQL, @reply, @question_id,
        @parent_id, @user_id)
        UPDATE questions
        SET reply = ?, question_id = ?, parent_id = ?, user_id = ?
        WHERE id = ?;
      SQL
  end
end
