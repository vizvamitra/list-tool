module ListTool
  module App

    class HelpCommand

      def self.match? arg
        ['h', '-h', 'help', '--help'].include? arg
      end

      def self.parse argv
        {}
      end

      def self.execute options, lister
        Printer.print_usage
      end

      def self.help
        "  -h,  --help\t\t\tPrint this message"
      end

    end
  end
end