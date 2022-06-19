module Sample
  module Column
    def value
      return send(_key) if respond_to?(_key)
      return _render.call if _render

      if _key == :id
        birthday = Date.today.ago((10...10000).to_a.sample.day)
        age = (Date.today.strftime('%Y%m%d').to_i - birthday.strftime('%Y%m%d').to_i) / 10000
        _param.merge!({ current: { birthday:, age: } })

        return _id
      end

      return Faker::Name.name if _key == :name
      return Faker::Games::Zelda.location if _key == :address
      return _param.current[:birthday].strftime('%Y%m%d') if _key == :birthday
      return _param.current[:age] if _key == :age

      ''
    end
  end
end
