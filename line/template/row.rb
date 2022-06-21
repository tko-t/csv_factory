# param:    Param.instance
# cursor:   row index
# id:       serial number from start_id
# row_data: row scoped parameters
module Template
  module Row
    def columns
      # Let's implement
      # .e.g
      [
        column(header: 'ID', key: :id, render: -> { id }),
        column(header: 'Name', key: :name, render: -> { Faker::Name.name })
      ]
    end
  end
end
