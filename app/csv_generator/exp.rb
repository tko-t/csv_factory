class CsvGenerator
  class Exp
    attr_reader :param

    def initialize
      @param = Param.instance
    end

    # overwritten
    def exps
      {}
    end
  end
end
