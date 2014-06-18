module ListTool
  module App

    class RenameListCommand < Command
      class << self

        def match? arg
          ['rl', 'rename-list'].include? arg
        end

        def parse argv
          fail_if_not_an_array(argv)
          
          list, name = argv.shift(2)
          ensure_existence_of('new name' => name)
          
          { name: name, list: parse_list_number!(list) }
        end

        def execute options, lister
          args = [ options[:list], options[:name] ]
          raise(ListNotFoundError, 'no list with given number') if lister.rename_list(*args).nil?
        end

        def help
          "  rl, rename-list LIST, NAME\tSet LIST name to NAME"
        end

      end
    end

  end
end