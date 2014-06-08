module ListTool
  module App

    class RenameListCommand

      def self.match? arg
        ['rl', 'rename-list'].include? arg
      end

      def self.parse argv
        raise ArgumentError, "expected argument to be an array, #{argv.class} given" unless argv.is_a? Array
        list, name = argv.shift(2)
        raise ArgumentError, 'list number not specified' if list.nil?
        raise ArgumentError, 'new name not specified' if name.nil?
        
        list = Integer(list) - 1 rescue raise(ArgumentError, 'list number must be an integer')
        raise ArgumentError, "list number can't be less than 1" if list < 0

        {name: name, list: list}
      end

      def self.execute options, lister
        args = [ options[:list], options[:name] ]
        raise(ListNotFoundError, 'no list with given number') if lister.rename_list(*args).nil?
      end

      def self.help
        "  rl, rename-list LIST, NAME\tSet LIST name to NAME"
      end

    end

  end
end