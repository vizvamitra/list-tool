module ListTool
  class Lister

    def initialize
      @data = ListerData.new
    end

    class << self
      def from_hash(hash)
        lister = Lister.new
        lister.instance_variable_set(:@data, ListerData.new(hash))
        lister
      end

      def from_json(json)
        data = JsonParser.parse(json)
        from_hash(data)
      end
    end

    def inspect
      "#<#{self.class}:0x#{self.__id__.to_s(16)}>"
    end

    def load(filename)
      json = FileManager.load(filename)
      @data = ListerData.new( JsonParser.parse(json) )
      self
    end

    def save(filename)
      FileManager.save(filename, @data)
    end

    def lists
      Hash[*@data.map{|list| [list.name, list.items.count] }.flatten]
    end

    def list(index=nil)
      list = get_list(index)
      return nil if list.nil?

      { name: list.name, items: list.items.map{|item| item.text} }
    end

    def default_list
      if @data.default_list
        list = @data.default_list
        { name: list.name, items: list.items.map{|item| item.text} }
      else
        nil
      end
    end

    def method_missing(method_name, *args, &block)
      if method_name =~ /_list$/
        receiver = @data
      elsif method_name =~ /_item$/
        if args[-1].is_a?(Hash) && args[-1].has_key?(:list)
          # then last argument is an options hash
          options = args.pop
          index = options[:list]
        end
        receiver = get_list(index)
        receiver || raise(ListNotFoundError, "list with given index doesn't exist")
      else
        super
      end

      receiver.send(method_name, *args, &block)
    rescue NoMethodError => e
      raise NoMethodError, "undefined method '#{method_name.to_s}' for #{self.inspect}"
    end

    private

    def get_list index=nil
      if index
        @data.lists[index]
      else
        raise NoDefaultListError, "default list not set" if @data.default_list.nil?
        @data.default_list
      end
    end

  end
end