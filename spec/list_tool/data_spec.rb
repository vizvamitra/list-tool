require_relative '../spec_helper.rb'

describe Data do 
  let (:data) { ListTool::Data.new(Factory.data) }

  describe '#initialize' do

    context 'success' do
      context 'from initial data' do
        it "stores objects of List class" do
          expect(data.lists[0]).to be_an_instance_of(ListTool::List)
        end

        it 'stores 2 lists' do
          expect(data.lists.length).to eq 2
        end

        it 'stores default list' do
          expect(data.default_list.name).to eq 'Todolist'
        end
      end

      context 'no arguments' do
        it 'creates new Data instance with empty array of lists' do
          expect(ListTool::Data.new().lists).to be_empty
        end
      end

    end

    context 'failure' do
      context 'argument is not a hash' do
        it 'raises ArgumentError' do
          expect{ListTool::Data.new('not_a_hash')}.to raise_error(ArgumentError)
        end
      end

      context 'no "lists" key in given hash' do
        it 'creates new Data instance with empty lists array' do
          expect(ListTool::Data.new({}).lists).to be_empty
        end
      end

      context '"lists" is not an array' do
        it 'raises ArgumentError' do
          expect{ListTool::Data.new("lists" => 'not_an_array')}.to raise_error(ArgumentError)
        end
      end
    end

  end


  describe '#add_list' do

    context 'hash given' do
      it 'adds new list to data' do
        data.add_list(Factory.list)
        expect(data.lists.length).to eq 3
      end
    end

    context 'string given' do
      it 'adds blank list with given name' do
        data.add_list('Testlist')
        expect(data.lists.last.name).to eq 'Testlist'
      end
    end

    it 'returns list object' do
      expect(data.add_list(Factory.list)).to be_an_instance_of(ListTool::List)
    end

  end


  describe '#remove_list' do

    context 'success' do
      it 'removes list with given number' do
        data.remove_list(1)
        expect(data.lists.length).to eq 1
      end

      it 'returns deleted list' do
        list = data.lists[1]
        expect(data.remove_list(1)).to eq list
      end

      context 'default list is being deleted' do
        it 'clears default list' do
          data.remove_list(0)
          expect(data.default_list).to be_nil
        end
      end   
    end

    context 'no list with given index' do
      it 'returns nil' do
        expect(data.remove_list(2)).to be_nil
      end
    end
     
  end


  describe '#replace_list' do

    context 'success' do
      it 'replaces given list with new one with given name' do
        data = ListTool::Data.new(Factory.data)
        expect(ListTool::List).to receive(:new).with('testlist')
        data.replace_list(1, 'testlist')
      end

      it 'returns new list' do
        expect( data.replace_list(1, 'testlist').name ).to eq 'testlist'
      end

      context 'default list is being replaces' do
        it 'clears default list' do
          data.replace_list(0, 'newlist')
          expect(data.default_list).to be_nil
        end
      end 
    end

    context 'no list with given index' do
      it 'returns nil' do
        expect(data.replace_list(2, 'new_name')).to be_nil
      end
    end
  end


  describe '#set_default_list' do

    context 'success' do
      it 'replaces default list' do
        data.set_default_list(1)
        expect(data.default_list).to eq data.lists[1]
      end

      it 'returns new defaut list' do
        expect(data.set_default_list(1)).to eq data.lists[1]
      end
    end

    context 'failure' do

      context 'argument is not an integer' do
        it 'raises ArgumentError' do
          expect{data.set_default_list('bad_int')}.to raise_error(ArgumentError)
        end
      end

      context 'no list with given index' do
        it 'returns nil' do
          expect(data.set_default_list(2)).to be_nil
        end

        it 'does not affect on default list' do
          data.set_default_list(2)
          expect(data.default_list).to eq data.lists[0]
        end
      end

    end

  end


  describe '#move_list' do

    context 'success' do
      it 'moves list up' do
        data.move_list(1, :up)
        expect(data.lists[0].name).to eq 'Wishlist'
      end

      it 'moves list down' do
        data.move_list(0, :down)
        expect(data.lists[1].name).to eq 'Todolist'
      end
    end

    context 'failure' do

      context 'too high index' do
        it 'does nothing when moving up' do
          lists = data.lists.dup
          data.move_list(2, :up)
          expect(data.lists).to eq lists
        end

        it 'does nothing when moving down' do
          lists = data.lists.dup
          data.move_list(2, :down)
          expect(data.lists).to eq lists
        end
      end

      context 'too low index' do
        it 'does nothing when moving up' do
          lists = data.lists.dup
          data.move_list(0, :up)
          expect(data.lists).to eq lists
        end

        it 'does nothing when moving down' do
          lists = data.lists.dup
          data.move_list(-1, :down)
          expect(data.lists).to eq lists
        end
      end
    end

  end


  describe '#to_json' do
    it 'returns correct json' do
      expect(data.to_json).to eq Factory.json
    end
  end

end