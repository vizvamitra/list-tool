require_relative '../spec_helper.rb'

describe ListTool::Lister do
  let(:lister){ ListTool::Lister.from_hash(Factory.data) }

  describe '#initialize' do

    it 'creates Lister with empty data' do
      expect(ListTool::ListerData).to receive(:new).with no_args
      ListTool::Lister.new
    end

  end


  describe '.from_hash' do
    it 'creates new Lister from given hash' do
      expect( lister.lists ).to eq( {'Todolist'=>2, 'Wishlist'=>0} )
    end
  end


  describe '.from_json' do
    it 'creates new Lister from given json string' do
      allow( ListTool::JsonParser ).to receive(:parse).and_return(Factory.data)

      lister = ListTool::Lister.from_json( Factory.json )
      expect( lister.lists ).to eq( {'Todolist'=>2, 'Wishlist'=>0} )
    end
  end


  describe '#lists' do
    it 'returna a hash of list names and item counts' do
      expect( lister.lists ).to eq( {'Todolist'=>2, 'Wishlist'=>0} )
    end
  end


  describe '#load' do
    let (:lister){ListTool::Lister.new}

    it 'loads data from given file' do
      json = Factory.json
      allow( ListTool::FileManager ).to receive(:load).and_return( json )
      allow( ListTool::JsonParser ).to receive(:parse).with(json).and_return( Factory.data )
      lister.load('data_file')
      expect( lister.lists ).to eq( {'Todolist'=>2, 'Wishlist'=>0} )
    end

    it 'returns self' do
      allow( ListTool::FileManager ).to receive(:load)
      allow( ListTool::JsonParser ).to receive(:parse)
      allow( ListTool::ListerData ).to receive(:new).and_return( ListTool::ListerData.new() )
      expect( lister.load('data_file') ).to eq lister
    end
  end


  describe '#save' do
    let (:lister){ListTool::Lister.new}
    let(:filename){ 'test_file' }

    it 'calls FileManager.save to save its data to file' do
      data = ListTool::ListerData.new
      lister.instance_variable_set(:@data, data)
      expect( ListTool::FileManager ).to receive(:save).with(filename, data)
      lister.save(filename)
    end
  end


  describe '#list' do

    context 'no options' do
      it 'returns hash with list name and array of item texts' do
        expect( lister.list(0) ).to eq( {name: 'Todolist', items: ['item1', 'item2']} )
      end
    end

    context 'list number not given' do
      it 'returns contents of default list' do
        expect( lister.list ).to eq( {name: 'Todolist', items: ['item1', 'item2']} )
      end
    end

  end


  describe '#default_list' do
    let(:data) { lister.instance_variable_get(:@data) }

    context 'when default list is set' do
      it 'returns hash with default ist name and array of item texts' do
        expect( lister.default_list ).to eq( {name: 'Todolist', items: ['item1', 'item2']} )
      end
    end

    context 'when default list is not set' do
      it 'returns nil' do
        allow( data ).to receive(:default_list).and_return(nil)
        expect( lister.default_list ).to be_nil
      end
    end
  end


  describe '#inspect' do
    it "returns '#<ListTool:obj_id>'" do
      expect( lister.inspect ).to eq "#<ListTool::Lister:0x#{lister.__id__.to_s(16)}>"
    end
  end


  describe '#method_missing' do
    let(:data) { lister.instance_variable_get(:@data) }

    context 'method name ends with _list' do
      it 'deligates method call to ListerData' do
        expect(data).to receive(:add_list).with("name")
        lister.add_list("name")
      end
    end

    context 'when method name ends with _item' do
      context 'and list index is not specified' do

        context 'if default list is set' do
          it 'deligates method call to default list' do
            list = data.default_list
            expect(list).to receive(:add_item).with("text")
            lister.add_item("text")
          end
        end

        context 'if default list is not set' do
          it 'raises NoDefaultListError' do
            allow( data ).to receive(:default_list).and_return(nil)
            expect{ lister.add_item }.to raise_error(ListTool::NoDefaultListError)
          end
        end

      end

      context 'and list index is specified' do

        context 'if list with given index exists' do
          it 'deligates method call to list with given index' do
            list = data.lists[1]
            expect(list).to receive(:add_item).with("text")
            lister.add_item("text", {list: 1})
          end
        end

        context 'if there is no list with given index' do
          it 'raises ListNotFoundError' do
            expect{ lister.add_item("text", {list: 3}) }.to raise_error(ListTool::ListNotFoundError)
          end
        end

      end
    end

    context 'for any other methods' do
      it 'raises NoMethodError' do
        expect{ lister.unknown_method }.to raise_error(NoMethodError)
      end
    end

  end


  describe '#get_list' do
    context 'when list index given' do
      it 'returns corresponding list object' do
        list = lister.instance_variable_get(:@data).instance_variable_get(:@lists)[0]
        expect( lister.send(:get_list, 0) ).to eq list
      end
    end

    context 'when list index not given' do

      context 'default list is set' do
        it 'returns default list' do
          list = lister.instance_variable_get(:@data).instance_variable_get(:@default_list)
          expect( lister.send(:get_list) ).to eq list
        end
      end

      context 'default list is not set' do
        it 'raises NoDefaultListError' do
          allow( lister.instance_variable_get(:@data) ).to receive(:default_list).and_return(nil)
          expect{ lister.send(:get_list) }.to raise_error(ListTool::NoDefaultListError)
        end
      end
      
    end
  end

end