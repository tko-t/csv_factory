# Props
#   _cursor  line number
#   _id      current id from start_id
#   _header   header label
#   _key      column key
#   _render   render proc
#   _param    Includes all of config, exp, args
module Template
  module Column

    def value
      super
      # Let's implement
      # send(key) if respond_to?(key)
      # .e.g
      # return _id if key == :id
    end

    # .e.g
    #def name
    #  return Faker::Name.name
    #end
  end
end
