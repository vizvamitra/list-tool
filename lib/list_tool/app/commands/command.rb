module ListTool
  module App

    class Command

      class << self

        def parse_number str, name
          index = Integer(str) - 1 rescue raise(ArgumentError, "#{name} number must be an integer")
          raise ArgumentError, "#{name} number can't be less than 1" if index < 0
          index
        end


        def parse_item_number str
          parse_number(str, "item")
        end

        def parse_list_number str
          parse_number(str, "list")
        end


        def parse_item_number! str
          raise ArgumentError, 'item number not specified' if str.nil?
          parse_item_number(str)
        end

        def parse_list_number! str
          raise ArgumentError, 'list number not specified' if str.nil?
          parse_list_number(str)
        end


        def ensure_existence_of hash
          hash.each do |key, value|
            raise ArgumentError, "#{key} not specified" if value.nil?
          end
        end

        def fail_if_not_an_array arg
          raise ArgumentError, "expected argument to be an array, #{arg.class} given" unless arg.is_a? Array
        end

      end

    end

  end
end