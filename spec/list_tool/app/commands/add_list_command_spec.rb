require_relative '../../../spec_helper.rb'

describe ListTool::App::AddListCommand do
  subject { ListTool::App::AddListCommand }

  describe '.match?' do
    it 'returns true if "al" or "add-list" given' do
      expect( subject.match? "al" ).to be_truthy
      expect( subject.match? "add-list" ).to be_truthy
    end

    it 'returns false otherwise' do
      expect( subject.match? "some-arg" ).to be_falsey
    end
  end


  describe '.parse' do
    it 'shifts 1 arg from ARGV' do
      argv = ['name']
      expect( argv ).to receive(:shift).with(no_args).and_return('name')
      subject.parse argv
    end

    context 'success' do
      it 'returns {name: "name"}' do
        expect( subject.parse(['name']) ).to eq( {name: 'name'} )
      end
    end

    context 'failure' do

      context 'when new name not given' do
        it 'raises ArgumentError' do
          expect{ subject.parse[] }.to raise_error(ArgumentError)
        end
      end

    end

  end


  describe '.execute' do
    let (:lister)  { double('lister')  }

    context 'success' do
      it 'calls lister.add_list with given name' do
        expect(lister).to receive(:add_list).with('list name').and_return("not_nil")
        subject.execute({name: 'list name'}, lister)
      end
    end

    context 'list creation failed' do
      it 'raises RuntimeError' do
        allow(lister).to receive(:add_list).and_return(nil)
        expect{ subject.execute({name: 'some name'}, lister) }.to raise_error(RuntimeError)
      end
    end
  end


  describe '.help' do
    it 'returns help message' do
      expect( subject.help ).to be_a String
    end
  end
end