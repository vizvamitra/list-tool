module ListTool
  module App

    class UseCommand

      def self.match? arg
        ['u', 'use'].include? arg
      end

      def self.parse argv
        raise ArgumentError, "expected argument to be an array, #{argv.class} given" unless argv.is_a? Array
        list = argv.shift
        raise ArgumentError, "list number not specified" if list.nil?

        begin
          list = Integer( list ) - 1
        rescue
          raise ArgumentError, "list number must be an integer"
        end

        {list: list}
      end

      def self.execute options, lister
        raise(ListNotFoundError, 'no list with given number') if lister.set_default_list( options[:list] ).nil?
      end

      def self.help
        "  u,  use LIST\t\tSets default list"
      end

    end
  end
end