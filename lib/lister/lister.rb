module Lister
  class Lister

    def initialize
      @data = Data.new
    end

    def inspect
      "#<#{self.class}:0x#{self.__id__.to_s(16)}>"
    end

    def self.from_hash(hash)
      lister = Lister.new
      lister.instance_variable_set(:@data, Data.new(hash))
      lister
    end

    def self.from_json(json)
      data = JsonParser.parse(json)
      from_hash(data)
    end

    def load(filename)
      json = FileManager.load(filename)
      @data = Data.new( JsonParser.parse(json) )
      self
    end

    def save(filename)
      FileManager.save(filename, @data)
    end

    def lists
      @data.map { |list| list.name }
    end

    def list(index)
      return nil if @data.lists[index].nil?
      @data.lists[index].map{ |item| item.text }
    end

    def method_missing(name, *args, &block)
      if name =~ /_list$/
        object = @data
      elsif name =~ /_item$/
        object = if args[-1].is_a?(Hash) && args[-1].has_key?(:list)
                  return nil if @data.lists[ args[-1][:list] ].nil?
                  index = args.pop()[:list]
                  @data.lists[index]
                else
                  @data.default_list
                end
      else
        super
      end

      result = object.send(name, *args, &block)
      return nil if result.nil?
      self
    rescue NoMethodError => e
      raise NoMethodError, "undefined method '#{name.to_s}' for #{self.inspect}"
    end

  end
end