# dynamic_parametersが返すハッシュオブジェクトはparamに取り込まれます
#
# Props
#   param config, args を含んだParamが使用できる
module Sample3
  module DynamicParameter
    def dynamic_parameters
      # Let's implement
      # .e.g
      # { base_date: Date.today.ago(param.range.year) }
    end
  end
end
