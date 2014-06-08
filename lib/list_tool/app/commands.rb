require_relative './commands/add_item_command.rb'
require_relative './commands/show_items_command.rb'
require_relative './commands/add_list_command.rb'
require_relative './commands/show_lists_command.rb'
require_relative './commands/use_command.rb'
require_relative './commands/unknown_command.rb'

module ListTool
  module App

    class Commands
      COMMANDS = ListTool::App.constants.map {|const| ListTool::App.const_get(const)} - [self, Printer, Runner]

      def self.process argv, lister
        argv.is_a?(Array) || raise(ArgumentError, "expected first paramenter to be an Array, #{argv.class} given")
        argv << 'h' if argv.empty?
        param = argv.shift

        begin
          COMMANDS.each do |cmd|
            if cmd.match? param
              cmd.execute cmd.parse(argv), lister
              break
            end
          end
        end

      end

      def self.help
        COMMANDS.inject(""){|out, cmd| out << cmd.help << "\n" }
      end

    end

  end
end