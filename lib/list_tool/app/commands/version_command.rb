module ListTool
  module App

    class VersionCommand

      def self.match? arg
        ['v', '-v', 'version', '--version'].include? arg
      end

      def self.parse argv
        {}
      end

      def self.execute options, lister
        Printer.print_version
      end

      def self.help
        "  -v,  --version\t\tPrint version of program"
      end

    end
  end
end