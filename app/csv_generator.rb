# config    必須: csvに必要な情報をマップしたyamlファイル
# row_count 任意: 出力する行数
# filename  任意: 出力ファイル名(configでの指定より優先)
# headers   任意: ヘッダ出力の要(true)不要(false)
class CsvGenerator
  require_relative 'csv_generator/column'
  require_relative 'csv_generator/row'
  require_relative 'csv_generator/dynamic_parameter'
  require_relative 'csv_generator/param'

  attr_reader :param, :rows, :name

  BOM = "\uFEFF"

  def self.run(name, **options)
    requires(name) # 関連モジュールのロード

    implementation(name) # 実装

    # configの数だけ
    configs(name).sort.each do |yaml_path|
      config = YAML.load(File.read(yaml_path), symbolize_names: true)
      new(name, config, options)
        .built_in    # dynamic_parameterを内蔵
        .set_default # set deafaluts
        .build       # make rows
        .generate    # 出力
    end
  end

  # moduleを片っ端から実装
  def self.implementation(name)
    "#{name.camelize}::Generator".tap do |generator|
      prepend(generator.constantize) if generator.safe_constantize
    end

    "#{name.camelize}::DynamicParameter".tap do |dynamic_parameter|
      DynamicParameter.prepend(dynamic_parameter.constantize) if dynamic_parameter.safe_constantize
    end

    "#{name.camelize}::Row".tap do |row|
      Row.prepend(row.constantize) if row.safe_constantize
    end

    "#{name.camelize}::Column".tap do |column|
      Column.prepend(column.constantize) if column.safe_constantize
    end
  end

  # load all
  def self.requires(name)
    Dir.glob(File.join(File.expand_path('..', __dir__), 'line', name, '**/*.rb')).map {|rb| require rb }
  end

  # get yaml paths
  def self.configs(name)
    Dir.glob(File.join(File.expand_path('..', __dir__), 'line', name, 'configs', '*.y*ml'))
  end

  def initialize(name, config, options)
    @name  = name
    @param = Param.merge!(**config).merge!(options)
  end

  def built_in
    Param.merge!(DynamicParameter.new.dynamic_parameters || {})

    self
  end

  def encoding
    return Encoding::SHIFT_JIS if param.include?(:shift_jis)
    return Encoding::WINDOWS_31J if param.include?(:windows31j)

    Encoding::UTF_8
  end

  # 必須のキーがなければデフォルト値をセット
  def set_default
    param.merge!({ header: true }) unless param.include?(:header)
    param.merge!({ row_count: 10 }) unless param.include?(:row_count)
    param.merge!({ filename: "#{name}.csv" }) unless param.include?(:filename)
    param.merge!({ start_id: 0 }) unless param.include?(:start_id)
    param.merge!({ separator: ',' }) unless param.include?(:separator)
    param.merge!({ quotes: false }) unless param.include?(:quotes)
    param.merge!({ bom: false }) unless param.include?(:bom)
    param.merge!({ encoding: }) unless param.include?(:encoding)

    self
  end

  def build
    @rows = param.row_count.times.with_index(param.start_id).map do |cursor, id|
      row(cursor, id)
    end

    self
  end

  def row(cursor, index)
    Row.new(cursor, index)
  end

  def headers
    @rows.first.headers
  end

  def output_path
    path = File.join(File.expand_path('..', __dir__), 'csv', name)
    FileUtils.mkdir_p(path)

    File.join(path, param.filename)
  end

  def generate
    File.open(output_path, 'w', encoding: param.encoding, liberal_parsing: true, invalid: :replace, undef: :replace, replace: "?") do |f|
      f.write BOM if param.bom

      csv = CSV.new(f, force_quotes: param.quotes, col_sep: param.separator)

      csv << headers if param.header

      rows.each do |row|
        csv << row.values
      end
    end
  end
end
