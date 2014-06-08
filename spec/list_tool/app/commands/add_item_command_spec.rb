require_relative '../../../spec_helper.rb'

describe ListTool::App::AddItemCommand do
  subject { ListTool::App::AddItemCommand }

  describe '.match?' do
    it 'returns true if "a" or "add-item" given' do
      expect( subject.match? "a" ).to be_truthy
      expect( subject.match? "add-item" ).to be_truthy
    end

    it 'returns false otherwise' do
      expect( subject.match? "some-arg" ).to be_falsey
    end
  end


  describe '.parse' do

    it 'shifts 2 args from ARGV' do
      argv = ['text', '1']
      expect( argv ).to receive(:shift).with(2).and_return(['text', '1'])
      subject.parse argv
    end

    context 'success' do

      context 'when list number not given' do
        it 'returns {text: "item text"}' do
          argv = ['item_text']
          expect( subject.parse argv ).to eq( {text: 'item_text'} )
        end
      end

      context 'when list number given' do
        it 'returns {text: "item text", list: list_num}' do
          argv = ['item_text', "2"]
          expect( subject.parse argv ).to eq( {text: 'item_text', list: 1} )
        end
      end

    end

    context 'failure' do

      context 'when item text not given' do
        it 'raises ArgumentError' do
          expect{ subject.parse([]) }.to raise_error( ArgumentError )
        end
      end

      context 'when list number is not an integer' do
        it 'raises ArgumentError' do
          expect{ subject.parse(['text', 'not_an_int']) }.to raise_error( ArgumentError )
        end
      end

      context 'when not an array given' do
        it 'raises ArgumentError' do
          expect{ subject.parse "not_an_array" }.to raise_error( ArgumentError )
        end
      end

    end
  end


  describe '.execute' do
    let (:lister)  { ListTool::Lister.new  }

    context 'success' do
      it 'calls lister.add_item with given options' do
        expect(lister).to receive(:add_item).with('item text', {}).and_return("not_nil")
        subject.execute({text: 'item text'}, lister)
      end
    end

    context 'failure' do

      context 'when list not found' do
        it 'raises ListNotFoundError' do
          expect{ subject.execute({text: 'item text', list: 2}, lister) }.to raise_error(ListTool::ListNotFoundError )
        end
      end

      context 'when list not specified and no default list set' do
        it 'raises NoDefaultListError' do
          expect{ subject.execute({text: 'item text'}, lister) }.to raise_error(ListTool::NoDefaultListError )
        end
      end

    end
  end


  describe '.help' do
    it 'returns help message' do
      expect( subject.help ).to be_a String
    end
  end

end