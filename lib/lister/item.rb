module Lister
  class Item
    attr_accessor :text

    def initialize arg
      if arg.is_a?(String)
        @text = arg
      elsif arg.is_a?(Hash)
        raise(ArgumentError, "item text not found in given hash") unless arg['text'].is_a?(String)
        @text = arg["text"]
      else
        raise(ArgumentError, "argument expected to be Hash or String, #{arg.class} given")
      end
    end

    def to_json
      "{\"text\":\"#{@text}\"}"
    end

  end
end