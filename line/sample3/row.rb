# param:  Param.instance
# cursor: row index
# id:     serial number from start_id
module Sample3
  module Row
    def columns
      param.columns.map do |key, header|
        column(header:, key:)
      end
    end
  end
end
