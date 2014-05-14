require_relative '../spec_helper.rb'

describe Lister::FileManager do
  let(:fm){Lister::FileManager}

  describe '.load' do

    context 'success' do
      it 'loads json from specified file' do
        allow(File).to receive(:read).and_return('{"test":0}')
        expect(fm.load('some_file')).to eq '{"test":0}'
      end
    end

    context 'failure' do

      context 'access denied to specified file' do
        it 'raises FileAccessError' do
          allow(File).to receive(:read).and_raise(Errno::EACCES)
          expect{ fm.load('some_file') }.to raise_error(Lister::FileAccessError)
        end
      end

      context "file doesn't exist" do
        it 'raises NoFileError' do
          allow(File).to receive(:read).and_raise(Errno::ENOENT)
          expect{ fm.load('some_file') }.to raise_error(Lister::FileNotFoundError)
        end
      end

      context 'unknown error' do
        it 'raises IOError' do
          allow(File).to receive(:read).and_raise(StandardError)
          expect{ fm.load('some_file') }.to raise_error(IOError)
        end
      end

    end

  end


  describe '.save' do
    let(:filename){ "some_file" }
    let(:data){ Lister::Data.new }

    context 'success' do
      it 'saves given data to specified file' do
        file = double('File')
        allow(File).to receive(:open).with(filename, 'w').and_yield(file)
        expect(file).to receive(:<<).with('{"lists":[]}')

        Lister::FileManager.save(filename, data)
      end
    end

    context 'failure' do
      
      context 'access denied to specified file' do
        it 'raises FileAccessError' do
          allow(File).to receive(:open).with(filename, 'w').and_raise(Errno::EACCES)
          expect{ fm.save('some_file', data) }.to raise_error(Lister::FileAccessError)
        end
      end

      context "file doesn't exist" do
        it 'raises NoFileError' do
          allow(File).to receive(:open).with(filename, 'w').and_raise(Errno::ENOENT)
          expect{ fm.save('some_file', data) }.to raise_error(Lister::FileNotFoundError)
        end
      end

      context 'unknown error' do
        it 'raises IOError' do
          allow(File).to receive(:open).with(filename, 'w').and_raise(StandardError)
          expect{ fm.save('some_file', data) }.to raise_error(IOError)
        end
      end

    end

  end

end