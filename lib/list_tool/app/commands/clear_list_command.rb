module ListTool
  module App

    class ClearListCommand < Command
      class << self

        def match? arg
          ['cl', 'clear-list'].include? arg
        end

        def parse argv
          fail_if_not_an_array(argv)
          
          list = argv.shift
          {list: parse_list_number!(list)}
        end

        def execute options, lister
          raise(ListNotFoundError, 'no list with given number') if lister.clear_list(options[:list]).nil?
        end

        def help
          "  cl, clear-list LIST\t\tClear given LIST"
        end

      end
    end

  end
end