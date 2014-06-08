require_relative '../../../spec_helper.rb'

describe ListTool::App::ShowListsCommand do
  subject { ListTool::App::ShowListsCommand }

  describe '.match?' do
    it 'returns true if "sl" or "show-lists" given' do
      expect( subject.match? "sl" ).to be_truthy
      expect( subject.match? "show-lists" ).to be_truthy
    end

    it 'returns false otherwise' do
      expect( subject.match? "some-arg" ).to be_falsey
    end
  end


  describe '.parse' do
    it 'returns {}' do
      expect( subject.parse [] ).to eq( {} )
    end
  end


  describe '.execute' do
    let (:lister)  { ListTool::Lister.new  }
    let (:printer) { ListTool::App::Printer } 

    it 'gets array of lists' do
      expect(lister).to receive(:lists)
      allow(printer).to receive(:print_lists)
      subject.execute( {}, lister )
    end

    it 'sends array of lists to printer' do
      allow(lister).to receive(:lists).and_return(['list1'])
      expect(printer).to receive(:print_lists).with(['list1'])
      subject.execute( {}, lister )
    end
  end


  describe '.help' do
    it 'returns help message' do
      expect( subject.help ).to be_a String
    end
  end
end