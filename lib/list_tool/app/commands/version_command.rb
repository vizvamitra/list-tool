module ListTool
  module App

    class VersionCommand < Command
      class << self

        def match? arg
          ['v', '-v', 'version', '--version'].include? arg
        end

        def parse argv
          {}
        end

        def execute options, lister
          Printer.print_version
        end

        def help
          " -v,  --version\t\t\tPrint version"
        end

      end
    end

  end
end