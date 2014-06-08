require_relative '../../spec_helper.rb'

describe ListTool::App::Runner do
  subject { ListTool::App::Runner.new }

  describe '#initialize' do
    it 'stores data directory path' do
      expect( subject.instance_variable_get(:@datadir) ). to eq File.join(Dir.home, '.clt/')
    end

    it 'stores data file name' do
      expect( subject.instance_variable_get(:@datafile) ). to eq 'data.json'
    end

    it 'stores lister' do
      expect( subject.instance_variable_get(:@lister) ).to be_a ListTool::Lister
    end
  end


  describe '#load_data' do
    it 'loads data to lister' do
      file = subject.send(:datafile_fullname)
      expect( subject.instance_variable_get(:@lister) ).to receive(:load).with(file)
      subject.send(:load_data)
    end
  end


  describe '#ensure_data_dir' do
    let (:dir) { subject.instance_variable_get(:@datadir) }

    context "when data dir doesn't exist" do
      context 'success' do
        it 'creates data dir' do
          allow(Dir).to receive(:exist?).with(dir).and_return(false)
          expect(Dir).to receive(:mkdir).with(dir)
          subject.send(:ensure_data_dir)
        end
      end

      context 'failure' do
        it 'raises SystemCallError' do
          allow(Dir).to receive(:mkdir).and_raise( SystemCallError.new('some msg') )
          allow(Dir).to receive(:exist?).with(dir).and_return(false)
          expect{ subject.send(:ensure_data_dir) }.to raise_error(SystemCallError)
        end
      end
    end

    context 'when data dir exists' do
      it 'does nothing' do
        allow(Dir).to receive(:exist?).and_return(true)
        expect(Dir).not_to receive(:mkdir)
        subject.send(:ensure_data_dir)
      end
    end

  end


  describe '#ensure_data_file' do
    let(:file) { subject.send(:datafile_fullname) }

    context "when data file doesn't exist" do

      context 'success' do
        it 'creates data file with initial(empty) data' do
          allow(File).to receive(:exist?).with(file).and_return(false)
          fake_datafile = double('file')
          expect(File).to receive(:open).with(file, 'w').and_yield(fake_datafile)
          expect(fake_datafile).to receive(:<<).with( '{"lists":[]}' )

          subject.send(:ensure_data_file)
        end
      end

      context 'failure' do
        it 'raises SystemCallError' do
          allow(File).to receive(:open).and_raise( SystemCallError.new('some msg') )
          allow(File).to receive(:exist?).with(file).and_return(false)
          expect{ subject.send(:ensure_data_file) }.to raise_error(SystemCallError)
        end
      end
    end

  end


  describe '#ensure_data' do
    it 'calls "ensure_data_dir"' do
      expect(subject).to receive(:ensure_data_dir)
      allow(subject).to receive(:ensure_data_file)
      subject.send(:ensure_data)
    end

    it 'calls "ensure_data_file"' do
      allow(subject).to receive(:ensure_data_dir)
      expect(subject).to receive(:ensure_data_file)
      subject.send(:ensure_data)
    end
  end


  describe '#datafile_fullname' do
    it 'returns full datafile name' do
      file = File.join(subject.instance_variable_get(:@datadir),subject.instance_variable_get(:@datafile))
      expect(subject.send(:datafile_fullname)).to eq file
    end
  end


  describe '#run' do
    let (:lister) { subject.instance_variable_get(:@lister) }

    context 'success' do
      it 'ensures presence of data' do
        expect( subject ).to receive(:ensure_data)
        allow( subject ).to receive(:load_data)
        allow( ListTool::App::Commands ).to receive(:process)
        allow( lister ).to receive(:save)

        subject.run ['argv']
      end

      it 'loads data' do
        allow( subject ).to receive(:ensure_data)
        expect( subject ).to receive(:load_data)
        allow( ListTool::App::Commands ).to receive(:process)
        allow( lister ).to receive(:save)

        subject.run []
      end

      it 'starts command processing' do
        allow( subject ).to receive(:ensure_data)
        allow( subject ).to receive(:load_data)
        expect( ListTool::App::Commands ).to receive(:process).with(['argv'], lister)
        allow( lister ).to receive(:save)

        subject.run ['argv']
      end

      it 'saves data' do
        allow( subject ).to receive(:ensure_data)
        allow( subject ).to receive(:load_data)
        allow( ListTool::App::Commands ).to receive(:process)
        expect( lister ).to receive(:save)

        subject.run ['argv']
      end
    end

    context 'failure' do
      context 'when any of inner method calls ended with exception' do
        it 'passes this exception to Printer.error' do
          allow( subject ).to receive(:ensure_data).and_raise(error = StandardError)
          expect( ListTool::App::Printer ).to receive(:error).with(error)

          subject.run ['argv']
        end
      end
    end
  end

end