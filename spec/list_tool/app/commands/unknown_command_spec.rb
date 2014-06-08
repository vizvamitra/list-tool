require_relative '../../../spec_helper.rb'

describe ListTool::App::UnknownCommand do
  subject { ListTool::App::UnknownCommand }

  describe '.match?' do
    it 'returns true always' do
      expect( subject.match? (65+rand(26)).chr ).to be_truthy
    end

    it 'stores command to a class variable' do
      subject.match? "a"
      expect(subject.instance_variable_get(:@unknown_command)).to eq 'a'
    end
  end


  describe '.parse' do
    it 'does nothing and returns {}' do
      expect( subject.parse [] ).to eq({})
    end
  end


  describe '.execute' do
    it 'raises UnknownCommandError' do
      expect{ subject.execute({}, nil) }.to raise_error(ListTool::UnknownCommandError)
    end
  end

end