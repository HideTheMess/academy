require 'active_support/core_ext/object/try'
require 'active_support/inflector'
require_relative './db_connection.rb'

class AssocParams
  def other_class
  end

  def other_table
  end
end

class BelongsToAssocParams < AssocParams
  def initialize(name, params)
  end

  def type
  end
end

class HasManyAssocParams < AssocParams
  def initialize(name, params, self_class)
  end

  def type
  end
end

module Associatable
  def assoc_params
  end

  def belongs_to(name, params = {})
    define_method(name) do
      unless params[:class_name].nil?
        other_class_name = params[:class_name]
      else
        other_class_name = name.to_s.capitalize
        other_class_name.gsub!(/_[a-z]/) { |w| w[1].upcase }
      end

      unless params[:primary_key].nil?
        primary_key = params[:primary_key]
      else
        primary_key = :id
      end

      unless params[:foreign_key].nil?
        foreign_key = params[:foreign_key]
      else
        foreign_key = "#{ name }_id".to_sym
      end

      other_class = other_class_name.constantize
      other_table_name = other_class.table_name

      other_record = DBConnection.execute(<<-SQL, send(foreign_key))
        SELECT *
        FROM #{ other_table_name }
        WHERE id = ?
      SQL

      other_class.parse_all(other_record)
    end
  end

  def has_many(name, params = {})
    define_method(name) do
      unless params[:class_name].nil?
        other_class_name = params[:class_name]
      else
        other_class_name_snake = name.to_s.singularize
        other_class_name = other_class_name_snake.capitalize
        other_class_name.gsub!(/_[a-z]/) { |w| w[1].upcase }
      end

      unless params[:primary_key].nil?
        primary_key = params[:primary_key]
      else
        primary_key = :id
      end

      unless params[:foreign_key].nil?
        foreign_key = params[:foreign_key]
      else
        foreign_key = "#{ other_class_name_snake }_id".to_sym
      end

      other_class = other_class_name.constantize
      other_table_name = other_class.table_name

      other_records = DBConnection.execute(<<-SQL, send(primary_key))
        SELECT *
        FROM #{ other_table_name }
        WHERE owner_id = ?
      SQL

      other_class.parse_all(other_records)
    end
  end

  def has_one_through(name, assoc1, assoc2)
  end
end
