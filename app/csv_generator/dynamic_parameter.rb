class CsvGenerator
  class DynamicParameter
    attr_reader :param

    def initialize
      @param = Param.instance
    end

    # overwritten
    def dynamic_parameters
      {}
    end
  end
end
