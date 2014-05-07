module ListTool
  class ListTool
    attr_reader :data_path

    def initialize data_path = nil
      @data_path = data_path || nil
    end
  end
end