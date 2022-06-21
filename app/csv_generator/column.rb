# _cursor   line number
# _id       current id from start_id
# _header   header label
# _key      column key
# _render   can use proc
# _param    Param.instance
# _row_data row scoped parameters
# これらを駆使してvalueをひねり出す
class CsvGenerator
  class Column
    attr_reader :_cursor, :_id, :_header, :_key, :_render, :_param, :_row_data

    def initialize(cursor, id, row_data, header, key, render)
      @_cursor = cursor
      @_id = id
      @_header = header
      @_key = key
      @_render = render
      @_param = Param.instance
      @_row_data = row_data
    end
    
    # overwritten
    def value
      return send(_key) if respond_to?(_key)
      return _render.call if _render
    end
  end
end
