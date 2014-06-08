require_relative '../../../spec_helper.rb'

describe ListTool::App::DeleteListCommand do
  subject { ListTool::App::DeleteListCommand }

  describe '.match?' do
    it 'returns true if "dl" or "del-list" given' do
      expect( subject.match? "dl" ).to be_truthy
      expect( subject.match? "del-list" ).to be_truthy
    end

    it 'returns false otherwise' do
      expect( subject.match? "some-arg" ).to be_falsey
    end
  end


  describe '.parse' do
    it 'shifts 1 arg from ARGV' do
      argv = ['2']
      expect( argv ).to receive(:shift).with(no_args).and_return('2')
      subject.parse argv
    end

    context 'success' do
      it 'returns {list: list_num}' do
        expect( subject.parse(['2']) ).to eq( {list: 1} )
      end
    end

    context 'failure' do

      context 'when list number not given' do
        it 'raises ArgumentError' do
          expect{ subject.parse[] }.to raise_error(ArgumentError)
        end
      end

      context 'when list number is not a integer' do
        it 'raises ArgumentError' do
          expect{ subject.parse(["not_an_integer"]) }.to raise_error(ArgumentError)
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
    let (:lister)  { ListTool::Lister.new }

    context 'success' do
      it 'calls lister.delete_list with given list number' do
        expect(lister).to receive(:delete_list).with(2).and_return("not_nil")
        subject.execute({list: 2}, lister)
      end
    end

    context 'failure' do
      context 'when list not found' do
        it 'raises ListNotFoundError' do
          expect{ subject.execute({list: -2}, lister) }.to raise_error(ListTool::ListNotFoundError )
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