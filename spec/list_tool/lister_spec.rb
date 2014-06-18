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

    context 'success' do
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

    context 'failure' do
      context 'no list with given index' do
        it 'returns nil' do
          expect( lister.list(2) ).to be_nil
        end
      end

      context 'default list not set and list not given' do
        it 'raises NoDefaultListError' do
          lister = ListTool::Lister.new
          expect{ lister.list }.to raise_error(ListTool::NoDefaultListError)
        end
      end
    end

  end


  describe '#inspect' do
    it "returns '#<ListTool:obj_id>'" do
      expect( lister.inspect ).to eq "#<ListTool::Lister:0x#{lister.__id__.to_s(16)}>"
    end
  end


  describe '#method_missing' do

    context 'success' do

      it 'returns self' do
        expect( lister.add_item('text') ).to eq lister
      end

      context '_list method given' do
        it 'deligates method call to @data' do
          data = lister.instance_variable_get(:@data)
          expect( data ).to receive(:add_list).with('new_list')
          lister.add_list('new_list')
        end
      end

      context '_item method given' do

        context 'list number not specified' do
          it 'deligates method call to default list' do
            default_list = lister.instance_variable_get(:@data).default_list
            expect( default_list ).to receive(:add_item).with('new_item')

            lister.add_item('new_item')
          end
        end

        context 'list number specified' do
          it 'deligates method call to specified list' do
            list = lister.instance_variable_get(:@data).lists[0]
            expect( list ).to receive(:add_item).with('new_item')

            lister.add_item('new_item', list: 0)
          end
        end

      end

    end

    context 'failure' do

      context 'call to unknown method' do
        it 'raises NoMethodError' do
          message = "undefined method 'no_such_method' for #{lister.inspect}"
          expect{lister.no_such_method}.to raise_error(NoMethodError, message)
        end
      end

      context 'no list with specified number' do
        it 'returns nil' do
          expect( lister.add_item('new_item', list: 3) ).to be_nil
        end
      end

      context 'method returned nil' do
        it 'returns nil' do
          expect( lister.delete_item(3) ).to be_nil
        end
      end

      context 'list number not specified and default list not set' do
        it 'raises NoDefaultListError' do
          lister = ListTool::Lister.new
          expect{ lister.add_item('new item') }.to raise_error(ListTool::NoDefaultListError)
        end
      end

    end

  end

end