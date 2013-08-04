require './question_database'
require './user'
require './reply'
require './question_follower'
require './question_like'

class Question
  attr_reader :id, :title, :body, :author_id

  def initialize(question_hash)
    @id = question_hash['id']
    @title, @body = question_hash['title'], question_hash['body']
    @author_id = question_hash['author_id']
  end

  def self.find_by_author_id(author_id)
    questions = QuestionDatabase.instance.execute(<<-SQL, author_id)
      SELECT *
      FROM questions
      WHERE author_id = ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  def self.find_by_id(id)
    question = QuestionDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM questions
      WHERE id = ?
    SQL

    Question.new(question[0])
  end

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def author
    User.find_by_id(@author_id)
  end

  def followers
    QuestionFollower.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def save
    if @id.nil?
      QuestionDatabase.instance.execute(<<-SQL, @title, @body, @author_id)
        INSERT INTO
          questions (title, body, author_id)
        VALUES
          (?, ?, ?);
      SQL

      question = QuestionDatabase.instance.execute(<<-SQL, @title, @body,
        @author_id)
        SELECT *
        FROM questions
        WHERE title = ?
        AND body = ?
        AND author_id = ?
      SQL

      self = Question.new(question)
    else
      QuestionDatabase.instance.execute(<<-SQL, @title, @body, @author_id, @id)
        UPDATE questions
        SET title = ?, body = ?, author_id = ?
        WHERE id = ?;
      SQL
  end
end
