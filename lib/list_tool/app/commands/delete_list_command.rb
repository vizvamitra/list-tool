module ListTool
  module App

    class DeleteListCommand

      def self.match? arg
        ['dl', 'del-list'].include? arg
      end

      def self.parse argv
        raise ArgumentError, "expected argument to be an array, #{argv.class} given" unless argv.is_a? Array
        list = argv.shift
        raise ArgumentError, 'list number not specified' if list.nil?
        
        list = Integer(list) - 1 rescue raise(ArgumentError, 'list number must be an integer')
        raise ArgumentError, "list number can't be less than 1" if list < 0

        {list: list}
      end

      def self.execute options, lister
        raise(ListNotFoundError, 'no list with given number') if lister.delete_list(options[:list]).nil?
      end

      def self.help
        "  dl, del-list LIST\t\tDelete given LIST"
      end

    end

  end
end