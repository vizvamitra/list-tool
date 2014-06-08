module ListTool
  module App

    class ShowListsCommand

      def self.match? arg
        ['sl', 'show-lists'].include? arg
      end

      def self.parse argv
        {}
      end

      def self.execute options, lister
        lists = lister.lists
        Printer.print_lists(lists)
      end

      def self.help
        "  sl, show-lists\t\tPrints list of existing lists"
      end

    end

  end
end