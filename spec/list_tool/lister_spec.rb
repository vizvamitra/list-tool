require_relative '../spec_helper.rb'

describe ListTool::Lister do
  let(:lister){ ListTool::Lister.from_hash(Factory.data) }

  describe '#initialize' do

    it 'creates Lister with empty data' do
      expect(ListTool::Data).to receive(:new).with()
      ListTool::Lister.new
    end

  end


  describe '.from_hash' do
    it 'creates new Lister from given hash' do
      expect( lister.lists ).to eq ['Todolist', 'Wishlist']
    end
  end


  describe '.from_json' do
    it 'creates new Lister from given json string' do
      allow( ListTool::JsonParser ).to receive(:parse).and_return(Factory.data)

      lister = ListTool::Lister.from_json( Factory.json )
      expect( lister.lists ).to eq ['Todolist', 'Wishlist']
    end
  end


  describe '#lists' do
    it 'returna an array of list names' do
      expect( lister.lists ).to eq ['Todolist', 'Wishlist']
    end
  end


  describe '#load' do
    let (:lister){ListTool::Lister.new}

    it 'loads data from given file' do
      json = Factory.json
      allow( ListTool::FileManager ).to receive(:load).and_return( json )
      allow( ListTool::JsonParser ).to receive(:parse).with(json).and_return( Factory.data )
      lister.load('data_file')
      expect( lister.lists ).to eq ['Todolist', 'Wishlist']
    end
  end



end