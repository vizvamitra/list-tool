module ListTool
  module App

    class ReplaceItemCommand

      def self.match? arg
        ['r', 'replace-item'].include? arg
      end

      def self.parse argv
        raise ArgumentError, "expected argument to be an array, #{argv.class} given" unless argv.is_a? Array
        item, name = argv.shift(2)
        raise ArgumentError, 'item number not specified' if item.nil?
        raise ArgumentError, 'new name not specified' if name.nil?
        
        item = Integer(item) - 1 rescue raise(ArgumentError, 'item number must be an integer')
        raise ArgumentError, "item number can't be less than 1" if item < 0

        {name: name, item: item}
      end

      def self.execute options, lister
        args = [ options[:item], options[:name] ]
        raise(ItemNotFoundError, 'no item with given number') if lister.change_item(*args).nil?
      end

      def self.help
        "  r,  replace-item ITEM, TEXT\tSet ITEM text to TEXT"
      end

    end

  end
end