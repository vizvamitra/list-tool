module ListTool
  module App

    class ReplaceItemCommand < Command
      class << self

        def match? arg
          ['r', 'replace-item'].include? arg
        end

        def parse argv
          fail_if_not_an_array(argv)

          item, name = argv.shift(2)
          ensure_existence_of('new name' => name)

          { name: name, item: parse_item_number!(item) }
        end

        def execute options, lister
          args = [ options[:item], options[:name] ]
          raise(ItemNotFoundError, 'no item with given number') if lister.change_item(*args).nil?
        end

        def help
          "  r,  replace-item ITEM, TEXT\tSet ITEM text to TEXT"
        end

      end
    end

  end
end