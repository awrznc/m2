require 'yaml'
require 'fileutils'
require 'erb'
require 'base64'

class Builder
  attr_reader :data, :export

  def initialize(import, export)
    @data = open(import, 'r') do |f| YAML.load(f) end
    @export = export

    filename = File.join(File.dirname(__FILE__), '..', '..', 'share', 'template.html.erb')
    @html_tamplate = ERB.new(File.read(filename))

    filename = File.join(File.dirname(__FILE__), '..', '..', 'share', 'template.svg.erb')
    @svg_tamplate = ERB.new(File.read(filename))
    p @data
  end

  def build
    contents = @data['page']['contents'].map do |content|
      image = Base64.strict_encode64(open(content['image']).read)
      @svg_tamplate.result(binding)
    end

    self.make_export_dir
    self.export_generate_contents(@html_tamplate.result(binding))
  end

  private

  # 出力先のディレクトリを再帰的に作成します。
  def make_export_dir
    FileUtils.mkdir_p(@export)
  end

  # 作成したコンテンツを出力します。
  def export_generate_contents(content)
    File.open("#{@export}/index.html", mode = "w") do |file|
      file.write(content)
    end
  end
end
