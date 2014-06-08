module ListTool
  module App

    class AddItemCommand

      def self.match? arg
        ['a', 'add-item'].include? arg
      end

      def self.parse argv
        raise ArgumentError, "expected argument to be an array, #{argv.class} given" unless argv.is_a? Array

        item, list = argv.shift(2)
        raise ArgumentError, 'item text should be specified when adding an item' if item.nil?

        out = {text: item}
        
        begin
          out[:list] = Integer(list) - 1
        rescue ArgumentError
          raise ArgumentError, 'list number must be an integer'
        end if list

        out
      end

      def self.execute options, lister
        args = [ options.delete(:text) ]
        args << options if options[:list]
        raise(ListNotFoundError, 'no list with given number') if lister.add_item(*args).nil?
      end

      def self.help
        "  a,  add-item TEXT [LIST]\tAdds item with TEXT to given or default list"
      end

    end

  end
end