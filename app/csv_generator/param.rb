class CsvGenerator::Param
  include Singleton

  def self.merge!(hash)
    instance.merge!(hash)
  end

  def merge!(hash)
    hash.each do |k, v|
      self.class.attr_reader k unless instance_values.symbolize_keys.keys.include?(k.to_sym)
      instance_variable_set("@#{k}", v)
    end

    self
  end

  def self.to_h
    instance.to_h
  end

  def to_h
    instance_values.symbolize_keys
  end

  def include?(key)
    respond_to?(key)
  end
end
