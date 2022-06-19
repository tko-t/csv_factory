module Sample2
  module Column
    def value
      _param.rows[_cursor][_key]
    end
  end
end
