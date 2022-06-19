module Sample2
  module Row
    def columns
      param.columns.map do |k, v|
        column(header: v, key: k)
      end
    end
  end
end

