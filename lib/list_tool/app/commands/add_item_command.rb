module ListTool
  module App

    class AddItemCommand

      def self.match? arg
        ['a', 'add-item'].include? arg
      end

      def self.parse argv
        raise ArgumentError, "expected argument to be an array, #{argv.class} given" unless argv.is_a? Array

        item, list = argv.shift(2)
        raise ArgumentError, 'item text not specified' if item.nil?

        out = {text: item}
        
        if list
          out[:list] = Integer(list) - 1 rescue raise(ArgumentError, 'list number must be an integer')
          raise ArgumentError, "list number can't be less than 1" if out[:list] < 0
        end

        out
      end

      def self.execute options, lister
        args = [ options.delete(:text) ]
        args << options if options[:list]
        raise(ListNotFoundError, 'no list with given number') if lister.add_item(*args).nil?
      end

      def self.help
        "  a,  add-item TEXT [LIST]\tAdd item with TEXT to given or default list"
      end

    end

  end
end