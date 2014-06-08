require_relative '../../../spec_helper.rb'

describe ListTool::App::VersionCommand do
  subject { ListTool::App::VersionCommand }

  describe '.match?' do
    it 'returns true if "v", "-v", "version", or "--version" given' do
      expect( subject.match? "v" ).to be_truthy
      expect( subject.match? "-v" ).to be_truthy
      expect( subject.match? "version" ).to be_truthy
      expect( subject.match? "--version" ).to be_truthy
    end

    it 'returns false otherwise' do
      expect( subject.match? "some-arg" ).to be_falsey
    end
  end


  describe '.parse' do
    it 'always returns {}' do
      expect( subject.parse nil ).to eq( {} )
    end
  end


  describe '.execute' do
    it 'calls Printer.print_version' do
      expect(ListTool::App::Printer).to receive(:print_version)
      subject.execute( {}, nil )
    end
  end


  describe '.help' do
    it 'returns help message' do
      expect( subject.help ).to be_a String
    end
  end

end