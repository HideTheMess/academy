require_relative './db_connection'

module Searchable
  def where(params)
    where_clause = params.keys.map do |key|
      "#{key} = ?"
    end

    table_entry = DBConnection.execute(<<-SQL, params.values)
      SELECT *
      FROM #{ self.table_name }
      WHERE #{ where_clause.join(' AND ') }
    SQL

    new(table_entry.first)
  end
end