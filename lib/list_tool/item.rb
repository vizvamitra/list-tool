module ListTool

  class Item
    attr_reader :text

    def initialize arg
      if arg.is_a?(String)
        @text = arg.gsub('"', "'")
      elsif arg.is_a?(Hash)
        raise(ArgumentError, "item text not found in given hash") unless arg['text'].is_a?(String)
        @text = arg["text"].gsub('"', "'")
      else
        raise(ArgumentError, "argument expected to be Hash or String, #{arg.class} given")
      end
    end

    def text= new_text
      @text = new_text.gsub('"', "'")
    end

    def to_json
      "{\"text\":\"#{@text}\"}"
    end

  end

end