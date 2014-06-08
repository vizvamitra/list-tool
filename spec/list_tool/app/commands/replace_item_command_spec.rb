require_relative '../../../spec_helper.rb'

describe ListTool::App::ReplaceItemCommand do
  subject { ListTool::App::ReplaceItemCommand }

  describe '.match?' do
    it 'returns true if "r" or "replace-item" given' do
      expect( subject.match? "r" ).to be_truthy
      expect( subject.match? "replace-item" ).to be_truthy
    end

    it 'returns false otherwise' do
      expect( subject.match? "some-arg" ).to be_falsey
    end
  end


  describe '.parse' do
    it 'shifts 2 arg from ARGV' do
      argv = ['2', 'name']
      expect( argv ).to receive(:shift).with(2).and_return(['2', 'name'])
      subject.parse argv
    end

    context 'success' do
      it 'returns name and item num' do
        expect( subject.parse(['2', 'new name']) ).to eq( {name: "new name", item: 1} )
      end
    end

    context 'failure' do

      context 'when item number not given' do
        it 'raises ArgumentError' do
          expect{ subject.parse[] }.to raise_error(ArgumentError)
        end
      end

      context 'when item number is not a integer' do
        it 'raises ArgumentError' do
          expect{ subject.parse(["not_an_integer", 'new name']) }.to raise_error(ArgumentError)
        end
      end

      context 'when item number is less than 1' do
        it 'raises ArgumentError' do
          expect{ subject.parse(['0', 'new name']) }.to raise_error( ArgumentError )
        end
      end

      context 'when new name not given' do
        it 'raises ArgumentError' do
          expect{ subject.parse(["2"]) }.to raise_error(ArgumentError)
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
    let (:lister)  { ListTool::Lister.new }

    context 'success' do
      it 'calls lister.replace_item with given item number and name' do
        expect(lister).to receive(:change_item).with(2, "new name").and_return("not_nil")
        subject.execute({name: 'new name', item: 2}, lister)
      end
    end

    context 'failure' do

      context 'when item not found' do
        it 'raises ItemNotFoundError' do
          allow(lister).to receive(:change_item).and_return(nil)
          expect{ subject.execute({name: 'new name', item: -2}, lister) }.to raise_error( ListTool::ItemNotFoundError )
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