module ListTool
  module App

    class Colorizer
      class << self
        def colorize(string, code)
          "\x1B[#{code}m" + string + "\x1B[0m"
        end
        
        def red(string); colorize(string, 31); end
        def green(string); colorize(string, 32); end
        def blue(string); colorize(string, 34); end
      end
    end

  end
end