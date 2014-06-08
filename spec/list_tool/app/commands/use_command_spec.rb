require_relative '../../../spec_helper.rb'

describe ListTool::App::UseCommand do
  subject { ListTool::App::UseCommand }

  describe '.match?' do
    it 'returns true if "u" or "use" given' do
      expect( subject.match? "u" ).to be_truthy
      expect( subject.match? "use" ).to be_truthy
    end

    it 'returns false otherwise' do
      expect( subject.match? "some-arg" ).to be_falsey
    end
  end


  describe '.parse' do
    context 'success' do
      it 'returns {List: list_num}' do
        expect( subject.parse(["2"]) ).to eq( {list: 1} )
      end
    end

    context 'failure' do
      context 'when list number not given' do
        it 'raises ArgumentError' do
          expect{ subject.parse([]) }.to raise_error( ArgumentError )
        end
      end

      context 'when list number is not an integer' do
        it 'raises ArgumentError' do
          expect{ subject.parse(['not_an_int']) }.to raise_error( ArgumentError )
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
    context 'success' do
      it 'sets default list' do
        lister = double()
        expect( lister ).to receive(:set_default_list).with(1).and_return("not_nil")
        subject.execute({list: 1}, lister)
      end
    end

    context 'failure' do
      context 'when list not found' do
        it 'raises ListNotFoundError' do
          lister = ListTool::Lister.new
          expect{ subject.execute({list: 1}, lister) }.to raise_error(ListTool::ListNotFoundError)
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