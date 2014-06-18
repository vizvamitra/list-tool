module ListTool
  module App

    class UseCommand < Command
      class << self

        def match? arg
          ['u', 'use'].include? arg
        end

        def parse argv
          fail_if_not_an_array(argv)
          
          list = argv.shift

          { list: parse_list_number!(list) }
        end

        def execute options, lister
          raise(ListNotFoundError, 'no list with given number') if lister.set_default_list( options[:list] ).nil?
        end

        def help
          "  u,  use LIST\t\t\tSet default list"
        end

      end
    end

  end
end