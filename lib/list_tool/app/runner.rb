module ListTool
  module App

    class Runner

      def initialize
        @datadir = File.join(Dir.home, '.clt/')
        @datafile = 'data.json'

        @lister = Lister.new
      end

      def run argv
        ensure_data
        load_data
        Commands.process argv, @lister
        @lister.save datafile_fullname
      rescue => e
        Printer.error(e)
      end

      private

      def datafile_fullname
        File.join(@datadir, @datafile)
      end

      def load_data
        @lister.load File.join(@datadir, @datafile)
      end

      def ensure_data
        ensure_data_dir
        ensure_data_file
      end

      def ensure_data_dir
        Dir.mkdir(@datadir) unless Dir.exist?(@datadir)
      rescue SystemCallError
        raise SystemCallError, "unable to create data folder"
      end

      def ensure_data_file
        unless File.exist? datafile_fullname
          File.open(datafile_fullname, 'w') {|f| f << '{"lists":[]}' }
        end
      rescue SystemCallError
        raise SystemCallError, "unable to create data file"
      end

    end

  end
end