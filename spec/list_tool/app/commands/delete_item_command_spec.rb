require_relative '../../../spec_helper.rb'

describe ListTool::App::DeleteItemCommand do
  subject { ListTool::App::DeleteItemCommand }

  describe '.match?' do
    it 'returns true if "d" or "del-item" given' do
      expect( subject.match? "d" ).to be_truthy
      expect( subject.match? "del-item" ).to be_truthy
    end

    it 'returns false otherwise' do
      expect( subject.match? "some-arg" ).to be_falsey
    end
  end


  describe '.parse' do

    it 'shifts 2 args from ARGV' do
      argv = ['2', '1']
      expect( argv ).to receive(:shift).with(2).and_return(['2', '1'])
      subject.parse argv
    end

    context 'success' do

      context 'when list number not given' do
        it 'returns {item: item_num}' do
          argv = ["2"]
          expect( subject.parse argv ).to eq( {item: 1} )
        end
      end

      context 'when list number given' do
        it 'returns {text: "item text", list: list_num}' do
          argv = ["2", "1"]
          expect( subject.parse argv ).to eq( {item: 1, list: 0} )
        end
      end

    end

    context 'failure' do

      context 'when item number not given' do
        it 'raises ArgumentError' do
          expect{ subject.parse([]) }.to raise_error( ArgumentError )
        end
      end

      context 'when list number is not an integer' do
        it 'raises ArgumentError' do
          expect{ subject.parse(['2', 'not_an_int']) }.to raise_error( ArgumentError )
        end
      end

      context 'when list number is less than 1' do
        it 'raises ArgumentError' do
          expect{ subject.parse(['2', '0']) }.to raise_error( ArgumentError )
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
    let(:lister) { ListTool::Lister.new }

    context 'success' do
      context 'when list number is given' do
        it 'calls lister.delete_item with item_num, {list: list_num}' do
          expect(lister).to receive(:delete_item).with(2, {list: 2}).and_return("not_nill")
          subject.execute({item: 2, list: 2}, lister)
        end
      end

      context 'when list number is not given' do
        it 'calls lister.delete_item with no args' do
          expect(lister).to receive(:delete_item).with(2).and_return("not_nill")
          subject.execute({item: 2}, lister)
        end
      end
    end

    context 'failure' do
      context 'when list not found' do
        it 'raises ListNotFoundError' do
          expect{ subject.execute({item: 2, list: 2}, lister) }.to raise_error(ListTool::ListNotFoundError )
        end
      end

      context 'when list not specified and no default list set' do
        it 'raises NoDefaultListError' do
          expect{ subject.execute({item: 2}, lister) }.to raise_error(ListTool::NoDefaultListError )
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