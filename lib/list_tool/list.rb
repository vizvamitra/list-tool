module ListTool
  class List

    attr_reader :name, :items

    def initialize(arg=nil)
      if arg.respond_to?(:to_str)
        @name = arg
        @items = []
      elsif arg.is_a?(Hash)
        prepare_data(arg)

        @name = arg['name']

        @items = []
        arg['items'].each do |item|
          add_item(item)
        end
      else
        raise(ArgumentError, "argument expected to be Hash or String, #{arg.class} given")
      end
    end

    def add_item text
      @items << Item.new(text)
    end

    def delete_item num
      @items.delete_at(num)
    end

    def move_item num, direction
      case direction
      when :up
        return unless (1...@items.length).include?(num)
        @items[num], @items[num-1] = @items[num-1], @items[num]
      when :down
        return unless (0...(@items.length-1)).include?(num)
        @items[num], @items[num+1] = @items[num+1], @items[num]
      end
    end

    def rename str
      raise ArgumentError, 'string expected' unless str.is_a?(String)
      @name = str
    end

    def to_json
      json = "{\"name\":\"#{@name}\",\"items\":["
      @items.each do |item|
        json += item.to_json
        json += ',' unless item == @items.last
      end
      json += ']}'
    end

  private

    def prepare_data data
      data['items'] ||= []
      data['name'] ||= 'Anonimous list'

      data['name'].respond_to?(:to_str) || raise(ArgumentError, 'name is not a string')      
      data['items'].is_a?(Array) || raise(ArgumentError, '"items" is not an array')
    end

  end
end