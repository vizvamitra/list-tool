module ListTool
  module App

    class Printer

      def self.error error
        puts "#{"ERROR".red}: #{error.message}\n"
      end

      def self.print_items list
        out = "Printing #{list[:name].green}:\n"
        list[:items].each.with_index do |item, index|
          out << "  %2i. %s\n" % [index+1, item]
        end
        puts out
      end

      def self.print_lists lists
        out = "Printing lists:\n"
        lists.each.with_index do |list, index|
          out << "  %2i. %s (%i)\n" % [index+1, list[0], list[1]]
        end
        puts out
      end

      def self.print_usage
        out = "#{'USAGE'.green}: clt COMMAND [OPTIONS]\n\nCOMMANDS:\n"
        Commands::COMMANDS.each do |cmd|
          out << cmd.help << "\n"
        end
        puts out
      end

      def self.print_version
        puts "clt version #{VERSION}"
      end

    end

  end
end