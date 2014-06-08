require_relative '../../../spec_helper.rb'

describe ListTool::App::HelpCommand do
  subject { ListTool::App::HelpCommand }

  describe '.match?' do
    it 'returns true if "h", "-h", "help" or "--help" given' do
      expect( subject.match? "h" ).to be_truthy
      expect( subject.match? "-h" ).to be_truthy
      expect( subject.match? "help" ).to be_truthy
      expect( subject.match? "--help" ).to be_truthy
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
    it 'calls Printer.print_usage' do
      expect(ListTool::App::Printer).to receive(:print_usage)
      subject.execute( {}, nil )
    end
  end


  describe '.help' do
    it 'returns help message' do
      expect( subject.help ).to be_a String
    end
  end

end