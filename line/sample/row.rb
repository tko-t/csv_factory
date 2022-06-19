module Sample
  module Row
    def columns
      [
        column(header: 'ID',       key: :id),
        column(header: 'Name',     key: :name),
        column(header: 'Address',  key: :address),
        column(header: 'BirthDay', key: :birthday),
        column(header: 'Age',      key: :age),
      ]
    end
  end
end

