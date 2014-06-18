module ListTool
  module App

    class AddListCommand < Command
      class << self

        def match? arg
          ['al', 'add-list'].include? arg
        end

        def parse argv
          fail_if_not_an_array(argv)

          name = argv.shift
          ensure_existence_of("list name" => name)

          {name: name}
        end

        def execute options, lister
          raise(RuntimeError, "list creation failed") if lister.add_list(options[:name]).nil?
        end

        def help
          "  al, add-list NAME\t\tCreate list with NAME"
        end

      end
    end

  end
end