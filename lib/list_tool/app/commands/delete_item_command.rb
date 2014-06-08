module ListTool
  module App

    class DeleteItemCommand

      def self.match? arg
        ['d', 'del-item'].include? arg
      end

      def self.parse argv
        raise ArgumentError, "expected argument to be an array, #{argv.class} given" unless argv.is_a? Array

        item, list = argv.shift(2)
        raise ArgumentError, 'item number not specified' if item.nil?

        out = {item: Integer(item) - 1} rescue raise(ArgumentError, 'item number must be an integer')
        
        if list
          out[:list] = Integer(list) - 1 rescue raise(ArgumentError, 'list number must be an integer')
          raise ArgumentError, "list number can't be less than 1" if out[:list] < 0
        end

        out
      end

      def self.execute options, lister
        args = [ options[:item] ]
        args << {list: options[:list]} if options[:list]
        raise(ListNotFoundError, 'no list with given number') if lister.delete_item(*args).nil?
      end

      def self.help
        "  d,  del-item ITEM [LIST]\tDelete ITEM from given or default list"
      end

    end

  end
end