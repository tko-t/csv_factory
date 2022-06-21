# Props
#   _cursor  line number
#   _id      current id from start_id
#   _header   header label
#   _key      column key
#   _render   render proc
#   _param    Includes all of config, dynamic_parameter, args
#   _row_data row scoped parameters
module Sample3
  module Column
    def id
      _id
    end

    def name
      Faker::Name.name
    end

    def address
      [Faker::Address.state, Faker::Address.city, [rand(10)+1, rand(100)+1, rand(10)+1].join('-')].join(' ')
    end

    def birthday
      birthday = _row_data[:birthday] = Date.today.ago((rand(40000)+1).days)
      birthday.strftime('%Y/%m/%d')
    end

    def age
      (Date.today.strftime('%Y%m%d').to_i - _row_data[:birthday].strftime('%Y%m%d').to_i) / 10000
    end
  end
end
