module ListTool
  class Lister

    def initialize
      @data = Data.new
    end

    def self.from_hash hash
      lister = Lister.new
      lister.instance_variable_set(:@data, Data.new(hash))
      lister
    end

    def self.from_json json
      data = JsonParser.parse(json)
      from_hash(data)
    end

    def lists
      @data.lists.map { |list| list.name }
    end

    def load filename
      json = FileManager.load(filename)
      @data = Data.new( JsonParser.parse(json) )
    end

  end
end