require_relative '../../../spec_helper.rb'

describe ListTool::App::ShowItemsCommand do
  subject { ListTool::App::ShowItemsCommand }

  describe '.match?' do
    it 'returns true if "s" or "show-items" given' do
      expect( subject.match? "s" ).to be_truthy
      expect( subject.match? "show-items" ).to be_truthy
    end

    it 'returns false otherwise' do
      expect( subject.match? "some-arg" ).to be_falsey
    end
  end


  describe '.parse' do
    it 'shifts 1 arg from ARGV' do
      argv = ['text']
      expect( argv ).to receive(:shift).with(no_args)
      subject.parse argv
    end

    context 'success' do
      context 'when list number is not given' do
        it 'returns empty hash' do
          expect( subject.parse([]) ).to eq( {} )
        end
      end

      context 'when list number is given' do
        it 'returns {list: list_num}' do
          expect( subject.parse(["1"]) ).to eq( {list: 0} )
        end
      end
    end

    context 'failure' do
      context 'when list number is not an integer' do
        it 'raises ArgumentError' do
          expect{ subject.parse(['not_an_int']) }.to raise_error( ArgumentError )
        end
      end

      context 'when list number is less than 1' do
        it 'raises ArgumentError' do
          expect{ subject.parse(['0']) }.to raise_error( ArgumentError )
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
    let (:printer) { ListTool::App::Printer } 

    context 'success' do
      context 'list number not given' do
        it 'gets default list contents' do
          expect(lister).to receive(:list).with(no_args).and_return([])
          allow(printer).to receive(:print_items)
          subject.execute({}, lister)
        end
      end

      context 'list number is given' do
        it 'gets given list contents' do
          expect(lister).to receive(:list).with(1).and_return([])
          allow(printer).to receive(:print_items)
          subject.execute({list: 1}, lister)
        end
      end

      it 'calls printer.print_items' do
        allow(lister).to receive(:list).with(no_args).and_return(['item1', 'item2'])
        expect(printer).to receive(:print_items).with(['item1', 'item2'])
        subject.execute({}, lister)
      end
    end

    context 'failure' do
      context 'when list not found' do
        it 'raises ListNotFoundError' do
          expect{ subject.execute({list: 2}, lister) }.to raise_error(ListTool::ListNotFoundError )
        end
      end

      context 'when list not specified and no default list set' do
        it 'raises NoDefaultListError' do
          expect{ subject.execute({}, lister) }.to raise_error(ListTool::NoDefaultListError )
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