class CsvGenerator
  class Row
    attr_reader :param, :cursor, :id

    # cursor: line number. Serial number starting from 0
    # id:     "start_id" specify at config or execution parameter
    def initialize(cursor, id)
      @param = Param.instance
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
      Column.new(cursor, id, header, key, render)
    end

    # overwritten
    def columns
      []
    end
  end
end
