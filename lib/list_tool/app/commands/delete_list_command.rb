module ListTool
  module App

    class DeleteListCommand < Command
      class << self

        def match? arg
          ['dl', 'del-list'].include? arg
        end

        def parse argv
          fail_if_not_an_array(argv)
          
          list = argv.shift
          
          {list: parse_list_number!(list)}
        end

        def execute options, lister
          raise(ListNotFoundError, 'no list with given number') if lister.delete_list(options[:list]).nil?
        end

        def help
          "  dl, del-list LIST\t\tDelete given LIST"
        end

      end
    end

  end
end