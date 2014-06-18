module ListTool

  class Data
    include Enumerable
    
    attr_reader :lists, :default_list

    def initialize(hash = {})
      raise ArgumentError, 'argument is not a hash' unless hash.respond_to?(:to_hash)

      hash['lists'] ||= []
      raise ArgumentError, 'incorrect data given' unless hash['lists'].respond_to?(:to_ary)

      @lists = []
      hash['lists'].each { |list_data| add_list(list_data) }

      set_default_list(hash['default']) if hash['default']
    end

    def each
      @lists.each { |list| yield(list) }
    end

    def add_list(data)
      list = List.new(data)
      @lists << list
      list
    end

    def delete_list(index)
      list = @lists.delete_at(index)
      @default_list = nil if @default_list == list
      list
    end

    def clear_list(index)
      return nil if @lists[index] == nil
      @lists[index].clear!
    end

    def rename_list(index, name)
      return nil if @lists[index] == nil
      @lists[index].rename(name)
    end

    def set_default_list(index)
      return nil if @lists[index] == nil
      @default_list = @lists[index]
    end

    def move_list(index, direction)
      case direction
      when :up
        return unless (1...@lists.length).include?(index)
        @lists[index], @lists[index-1] = @lists[index-1], @lists[index]
      when :down
        return unless (0...(@lists.length-1)).include?(index)
        @lists[index], @lists[index+1] = @lists[index+1], @lists[index]
      end
    end

    def to_json
      hash = {lists: @lists}
      hash.merge!(default: @lists.index(@default_list)) if @default_list
      hash.to_json
    end
      
  end
end