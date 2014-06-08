module ListTool
  module App

    class AddListCommand

      def self.match? arg
        ['al', 'add-list'].include? arg
      end

      def self.parse argv
        raise ArgumentError, "expected argument to be an array, #{argv.class} given" unless argv.is_a? Array
        name = argv.shift
        raise ArgumentError, 'list name not specified' if name.nil?
        raise ArgumentError, 'name is not a string' unless name.is_a? String

        {name: name}
      end

      def self.execute options, lister
        raise(RuntimeError, "list creation failed") if lister.add_list(options[:name]).nil?
      end

      def self.help
        "  al, add-list NAME\t\tCreate list with NAME"
      end

    end

  end
end