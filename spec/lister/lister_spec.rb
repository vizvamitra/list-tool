require_relative '../spec_helper.rb'

describe Lister::Lister do
  let(:lister){ Lister::Lister.from_hash(Factory.data) }

  describe '#initialize' do

    it 'creates Lister with empty data' do
      expect(Lister::Data).to receive(:new).with()
      Lister::Lister.new
    end

  end


  describe '.from_hash' do
    it 'creates new Lister from given hash' do
      expect( lister.lists ).to eq ['Todolist', 'Wishlist']
    end
  end


  describe '.from_json' do
    it 'creates new Lister from given json string' do
      allow( Lister::JsonParser ).to receive(:parse).and_return(Factory.data)

      lister = Lister::Lister.from_json( Factory.json )
      expect( lister.lists ).to eq ['Todolist', 'Wishlist']
    end
  end


  describe '#lists' do
    it 'returna an array of list names' do
      expect( lister.lists ).to eq ['Todolist', 'Wishlist']
    end
  end


  describe '#load' do
    let (:lister){Lister::Lister.new}

    it 'loads data from given file' do
      json = Factory.json
      allow( Lister::FileManager ).to receive(:load).and_return( json )
      allow( Lister::JsonParser ).to receive(:parse).with(json).and_return( Factory.data )
      lister.load('data_file')
      expect( lister.lists ).to eq ['Todolist', 'Wishlist']
    end

    it 'returns self' do
      allow( Lister::FileManager ).to receive(:load)
      allow( Lister::JsonParser ).to receive(:parse)
      allow( Lister::Data ).to receive(:new).and_return( Lister::Data.new() )
      expect( lister.load('data_file') ).to eq lister
    end
  end


  describe '#save' do
    let (:lister){Lister::Lister.new}
    let(:filename){ 'test_file' }

    it 'calls FileManager.save to save its data to file' do
      data = Lister::Data.new
      lister.instance_variable_set(:@data, data)
      expect( Lister::FileManager ).to receive(:save).with(filename, data)
      lister.save(filename)
    end
  end


  describe '#list' do

    context 'success' do
      context 'no options' do
        it 'returns array of item texts' do
          expect( lister.list(0) ).to eq ['item1', 'item2']
        end
      end
    end

    context 'failure' do
      context 'no list with given index' do
        it 'returns nil' do
          expect( lister.list(2) ).to be_nil
        end
      end
    end

  end


  describe '#inspect' do
    it "returns '#<Lister::Lister:obj_id>'" do
      expect( lister.inspect ).to eq "#<Lister::Lister:0x#{lister.__id__.to_s(16)}>"
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

    end

  end

end