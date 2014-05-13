module ListTool
  class FileManager

    def self.load filename
      File.read(filename)
    rescue Errno::EACCES
      raise FileAccessError, "can't read file '#{filename}': access denied"
    rescue Errno::ENOENT
      raise FileNotFoundError, "can't read file '#{filename}': file not found"
    rescue
      raise IOError, "can't read file '#{filename}': unknown error"
    end

    def self.save data, filename
      File.open(filename, 'w') { |f| f << data.to_json }
    end

  end
end