require_relative '../spec_helper.rb'

describe ListTool::List do

  let (:list) { ListTool::List.new(Factory.list) }

  describe '#initialize' do

    it 'stores items' do
      expect(list.items[0]).to be_an_instance_of(ListTool::Item)
    end

    context 'hash given' do

      context 'correct' do
        it 'stores list name' do
          expect(list.name).to eq 'Todolist'
        end

        it 'stores 2 items' do
          expect(list.items.length).to eq 2
        end

      end

      context 'incorrect' do
        context 'name is not a string' do
          it 'raises ArgumentError' do
            expect{ListTool::List.new({'name' => 123, 'items' => []})}.to raise_error(ArgumentError)
          end
        end

        context 'items is not an array or nil' do
          it 'raises ArgumentError' do
            expect{ListTool::List.new({'name' => 'name', 'items' => 'not an array'})}.to raise_error(ArgumentError)
          end
        end

        context 'items is nil' do
          it 'creates list with no items' do
            expect(ListTool::List.new({'name' => 'name'}).items.length).to be 0
          end
        end
      end

    end

    context 'string given' do
      let (:list) { ListTool::List.new('name') }

      it 'creates blank list' do
        expect(list.items).to be_empty
      end

      it 'stores name' do
        expect(list.name).to eq 'name'
      end

    end

    context 'wrong argument given' do
      it 'raises ArgumentError' do
        expect{ListTool::List.new(123)}.to raise_error(ArgumentError)
      end
    end

  end


  describe '#clear!' do
    it "clears items array" do
      list.clear!
      expect(list.items).to be_empty
    end
  end


  describe '#rename' do
    context 'argument is a string' do
      it 'renames list' do
        list.rename('new name')
        expect(list.name).to eq 'new name'
      end

      it 'returns old name' do
        expect( list.rename('new name') ).to eq 'Todolist'
      end
    end

    context 'argument is not a string' do
      it 'raises ArgumentError' do
        expect{list.rename(123)}.to raise_error(ArgumentError)
      end
    end
  end

  describe '#add_item' do
    it 'adds item to self' do
      list.add_item('new item')
      expect(list.items.length).to eq 3
    end
  end

  describe '#delete_item' do
    it 'removes item with given number' do
      list.delete_item(1)
      expect(list.items[1]).to be_nil
    end
  end

  describe '#move_item' do

    context 'correct pos given' do
      it 'moves item up' do
        list.move_item(1, :up)
        expect(list.items[0].text).to eq 'item2'
      end

      it 'moves item down' do
        list.move_item(0, :down)
        expect(list.items[1].text).to eq 'item1'
      end
    end

    context 'incorrect pos given' do

      context 'too high pos' do
        it 'does nothing when moving up' do
          items = list.items.dup
          list.move_item(2, :up)
          expect(list.items).to eq items
        end

        it 'does nothing when moving down' do
          items = list.items.dup
          list.move_item(2, :down)
          expect(list.items).to eq items
        end
      end

      context 'too low pos' do
        it 'does nothing when moving up' do
          items = list.items.dup
          list.move_item(0, :up)
          expect(list.items).to eq items
        end

        it 'does nothing when moving down' do
          items = list.items.dup
          list.move_item(-1, :down)
          expect(list.items).to eq items
        end
      end
    end

  end

  describe '#to_json' do
    it 'returns json representation of list' do
      json_str = "{\"name\":\"Todolist\",\"items\":[{\"text\":\"item1\"},{\"text\":\"item2\"}]}"
      expect(list.to_json).to eq json_str
    end
  end

end