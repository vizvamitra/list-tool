module ListTool
  module App

    class AddListCommand

      def self.match? arg
        ['al', 'add-list'].include? arg
      end

      def self.parse argv
        raise ArgumentError unless argv.is_a? Array
        name = argv.shift
        raise ArgumentError if name.nil?
        raise ArgumentError unless name.is_a? String

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