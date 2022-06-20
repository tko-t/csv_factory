# Props
#   _cursor  line number
#   _id      current id from start_id
#   _header   header label
#   _key      column key
#   _render   render proc
#   _param    Includes all of config, exp, args
module ImportCo
  module Column

    def value
      super || ""
    end

    def receive_number
      Faker::Games::Pokemon.name
    end
  end
end
