require 'erb'
require 'yaml'

module Rpgview
  class Generator
    SCHEMA_TEMPLATE = 'templates/view.sql.erb'

    attr_accessor :table, :view, :mappings

    def initialize(schema=nil)
      if schema
        @schema = schema
        set_bindings
      end
    end

    def generate
      template = ERB.new File.read(File.join(File.dirname(__FILE__), SCHEMA_TEMPLATE))
      template.result(binding).to_s
    end

    private

    def set_bindings
      data = YAML.load_file @schema
      @table = data['mapping']['table']
      @view = data['mapping']['view']
      @mappings = data['mapping']['mappings']
    end
  end
end