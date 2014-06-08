module ListTool
  module App

    class ShowItemsCommand

      def self.match? arg
        ['s', 'show-items'].include? arg
      end

      def self.parse argv
        raise ArgumentError, "expected argument to be an array, #{argv.class} given" unless argv.is_a? Array
        list = argv.shift

        if list
          list = Integer( list ) - 1 rescue raise(ArgumentError, 'list number must be an integer')
          raise ArgumentError, "list number can't be less than 1" if list < 0
        end

        list ? {list: list} : {}
      end

      def self.execute options, lister
        items = options[:list].nil? ? lister.list() : lister.list(options[:list])
        raise ListNotFoundError if items.nil?
        Printer.print_items( items )
      end

      def self.help
        "  s,  show-items [LIST]\t\tPrint contents of default or given list"
      end

    end

  end
end