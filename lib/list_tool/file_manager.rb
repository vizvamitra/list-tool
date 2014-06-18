module ListTool

  class FileManager

    class << self
      def load filename
        File.read(filename)
      rescue Errno::EACCES
        raise FileAccessError, "can't read file '#{filename}': access denied"
      rescue Errno::ENOENT
        raise FileNotFoundError, "can't read file '#{filename}': file not found"
      rescue
        raise IOError, "can't read file '#{filename}': unknown error"
      end

      def save filename, data
        File.open(filename, 'w') { |f| f << data.to_json }
      rescue Errno::EACCES
        raise FileAccessError, "can't open file '#{filename}': access denied"
      rescue Errno::ENOENT
        raise FileNotFoundError, "can't open file '#{filename}': file not found"
      rescue
        raise IOError, "can't open file '#{filename}': unknown error"
      end
    end

  end

end