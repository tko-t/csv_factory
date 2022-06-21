# Props
#   _cursor  line number
#   _id      current id from start_id
#   _header   header label
#   _key      column key
#   _render   render proc
#   _param    Includes all of config, dynamic_parameter, args
#   _row_data row scoped parameter
module Template
  module Column

    def value
      # Let's implement
      # .e.g
      # return _id if key == :id
      super
    end

    # .e.g
    #def name
    #  return Faker::Name.name
    #end
  end
end
