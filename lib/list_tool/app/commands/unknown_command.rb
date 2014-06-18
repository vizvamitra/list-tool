module ListTool
  module App

    class UnknownCommand < Command
      class << self

        def match? arg
          @unknown_command = arg
          true
        end

        def parse argv
          {}
        end

        def execute options, lister
          raise UnknownCommandError, "unknown command: '#{@unknown_command}'"
        end

        def help
          ""
        end

      end
    end

  end
end