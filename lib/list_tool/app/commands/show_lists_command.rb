module ListTool
  module App

    class ShowListsCommand < Command
      class << self

        def match? arg
          ['sl', 'show-lists'].include? arg
        end

        def parse argv
          {}
        end

        def execute options, lister
          lists = lister.lists
          Printer.print_lists(lists)
        end

        def help
          "  sl, show-lists\t\tPrint list of existing lists"
        end

      end
    end

  end
end