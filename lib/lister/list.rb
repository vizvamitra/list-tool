module Lister
  class List
    include Enumerable

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

    def clear!
      @items = []
    end

    def rename str
      raise ArgumentError, 'string expected' unless str.is_a?(String)
      old_name = @name
      @name = str
      old_name
    end

    def to_json
      json = "{\"name\":\"#{@name}\",\"items\":["
      @items.each do |item|
        json += item.to_json
        json += ',' unless item == @items.last
      end
      json += ']}'
    end

    def each
      @items.each { |item| yield(item) }
    end

    def add_item text
      @items << Item.new(text)
    end

    def delete_item num
      @items.delete_at(num)
    end

    def change_item index, new_text
      raise ArgumentError, 'index is not an integer' unless index.respond_to?(:to_int)
      raise ArgumentError, 'new text is not a string' unless new_text.respond_to?(:to_str)
      return nil if @items[index].nil?
      @items[index].text = new_text
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

  private

    def prepare_data data
      data['items'] ||= []
      data['name'] ||= 'Anonimous list'

      data['name'].respond_to?(:to_str) || raise(ArgumentError, 'name is not a string')      
      data['items'].is_a?(Array) || raise(ArgumentError, '"items" is not an array')
    end

  end
end