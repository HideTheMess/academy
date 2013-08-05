require_relative './associatable'
require_relative './db_connection'
require_relative './mass_object'
require_relative './searchable'

class SQLObject < MassObject
  def self.set_table_name(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name
  end

  def self.all
    all_array = DBConnection.execute(<<-SQL)
      SELECT *
      FROM #{table_name}
    SQL

    all_array.map do |table_entry|
      new(table_entry)
    end
  end

  def self.find(id)
    table_entry = DBConnection.execute(<<-SQL, id)
      SELECT *
      FROM #{table_name}
      WHERE id = ?
    SQL

    new(table_entry.first)
  end

  def create
    DBConnection.execute(<<-SQL, attribute_values[1..-1])
      INSERT INTO #{table_name} (attributes[1..-1].join(', '))
      VALUES ((['?'] * 10).join(', '))
    SQL
  end

  def update
    set_array = attributes.map do |attr_name|
      "#{attr_name} = ?"
    end
    set_array.shift

    DBConnection.execute(<<-SQL, attribute_values.rotate)
      UPDATE #{table_name}
      SET set_array.join(', ')
      WHERE id = [id]
    SQL
  end

  def save
  end

  def attribute_values
    attributes.map do |attribute|
      send(attribute)
    end
  end
end
