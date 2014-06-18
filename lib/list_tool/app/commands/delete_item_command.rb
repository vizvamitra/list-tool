module ListTool
  module App

    class DeleteItemCommand < Command
      class << self

        def match? arg
          ['d', 'del-item'].include? arg
        end

        def parse argv
          fail_if_not_an_array(argv)

          item, list = argv.shift(2)

          out = { item: parse_item_number!(item) } 
          out[:list] = parse_list_number(list) if list
          out
        end

        def execute options, lister
          args = [ options[:item] ]
          args << {list: options[:list]} if options[:list]
          raise(ListNotFoundError, 'no list with given number') if lister.delete_item(*args).nil?
        end

        def help
          "  d,  del-item ITEM [LIST]\tDelete ITEM from given or default list"
        end

      end
    end

  end
end