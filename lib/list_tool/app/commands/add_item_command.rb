module ListTool
  module App

    class AddItemCommand < Command
      class << self

        def match? arg
          ['a', 'add-item'].include? arg
        end

        def parse argv
          fail_if_not_an_array(argv)

          item, list = argv.shift(2)
          ensure_existence_of('item text' => item)

          out = {text: item}
          out[:list] = parse_list_number(list) if list
          out
        end

        def execute options, lister
          args = [ options.delete(:text) ]
          args << options if options[:list]
          raise(ListNotFoundError, 'no list with given number') if lister.add_item(*args).nil?
        end

        def help
          "  a,  add-item TEXT [LIST]\tAdd item with TEXT to given or default list"
        end

      end
    end

  end
end