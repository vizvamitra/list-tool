module ListTool
  module App

    class UnknownCommand

      def self.match? arg
        @unknown_command = arg
        true
      end

      def self.parse argv
        {}
      end

      def self.execute options, lister
        raise UnknownCommandError, "unknown command: '#{@unknown_command}'"
      end

      def self.help
        ""
      end

    end

  end
end