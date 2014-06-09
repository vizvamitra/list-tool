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

    it 'returns not nil' do
      expect(list.add_item('new item')).not_to be_nil
    end
  end

  describe '#delete_item' do

    context 'success' do
      it 'removes item with given number' do
        list.delete_item(1)
        expect(list.items[1]).to be_nil
      end

      it 'returns not nil' do
        expect( list.delete_item(1) ).not_to be_nil
      end
    end

    context 'no item with given number' do
      it 'returns nil' do
        expect( list.delete_item(3) ).to be_nil
      end 
    end
  end

  describe '#change_item' do
    context 'success' do
      it 'replaces text of speified item' do
        list.change_item(1, 'new_text')
        expect(list.items[1].text).to eq 'new_text'
      end

      it 'returns not nil' do
        expect( list.change_item(1, 'new_text') ).not_to be_nil
      end
    end

    context 'failure' do

      context 'no item with given index' do
        it 'returns nil' do
          expect( list.change_item(3, 'test') ).to be_nil
        end
      end

      context 'index is not an integer' do
        it 'raises ArgumentError' do
          expect{ list.change_item('abc', 'test') }.to raise_error(ArgumentError)
        end
      end

      context 'new_text is not a string' do
        it 'raises ArgumentError' do
          expect{ list.change_item(0, 1) }.to raise_error(ArgumentError)
        end
      end

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

      it 'returns not nil' do
        expect( list.move_item(1, :up) ).not_to be_nil
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

    it 'substitutes " with \"' do
      list = ListTool::List.new({"name" => 'name with ""', "items" => []})
      expect(list.to_json).to eq '{"name":"name with \"\"","items":[]}'
    end
  end

end