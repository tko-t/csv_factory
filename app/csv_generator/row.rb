class CsvGenerator
  class Row
    attr_reader :param, :row_data, :cursor, :id

    # cursor:   line number. Serial number starting from 0
    # id:       "start_id" specify at config or execution parameter
    # row_data: row scoped parameters
    def initialize(cursor, id)
      @param = Param.instance
      @row_data = init_row_data || {}
      @cursor = cursor
      @id = id
    end

    def headers
      columns.map(&:_header)
    end

    def values
      columns.map(&:value)
    end

    def column(header:, key:, render: nil)
      Column.new(cursor, id, row_data, header, key, render)
    end

    # overwritten
    def init_row_data
      {}
    end

    # overwritten
    def columns
      []
    end
  end
end
