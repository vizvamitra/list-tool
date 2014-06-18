module ListTool
  module App

    class Printer
      class << self
        def error error
          puts "#{Colorizer.red("ERROR")}: #{error.message}\n"
        end

        def print_items list
          out = "Printing #{Colorizer.green(list[:name])}:\n"
          list[:items].each.with_index do |item, index|
            out << "  %2i. %s\n" % [index+1, item]
          end
          puts out
        end

        def print_lists lists
          out = "Printing lists:\n"
          lists.each.with_index do |list, index|
            out << "  %2i. %s (%i)\n" % [index+1, list[0], list[1]]
          end
          puts out
        end

        def print_usage
          out = "#{Colorizer.green('USAGE')}: clt COMMAND [OPTIONS]\n\nCOMMANDS:\n"
          Commands::COMMANDS.each do |cmd|
            out << cmd.help << "\n"
          end
          puts out
        end

        def print_version
          puts "clt version #{VERSION}"
        end
      end
    end

  end
end