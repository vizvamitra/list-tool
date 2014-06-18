module ListTool
  module App

    class ShowItemsCommand < Command
      class << self

        def match? arg
          ['s', 'show-items'].include? arg
        end

        def parse argv
          fail_if_not_an_array(argv)
          
          list = argv.shift

          list ? {list: parse_list_number(list)} : {}
        end

        def execute options, lister
          items = options[:list].nil? ? lister.list() : lister.list(options[:list])
          raise ListNotFoundError if items.nil?
          Printer.print_items( items )
        end

        def help
          "  s,  show-items [LIST]\t\tPrint contents of default or given list"
        end

      end
    end

  end
end