module ListTool
  module App

    class HelpCommand < Command
      class << self

        def match? arg
          ['h', '-h', 'help', '--help'].include? arg
        end

        def parse argv
          {}
        end

        def execute options, lister
          Printer.print_usage
        end

        def help
          " -h,  --help\t\t\tPrint this message"
        end

      end
    end
  end
end