require_relative '../../spec_helper.rb'

describe ListTool::App::Commands do
  subject { ListTool::App::Commands }

  it 'stores command list' do
    commands = ListTool::App.constants.map {|c| ListTool::App.const_get(c)} - [ListTool::App::Commands, ListTool::App::Printer, ListTool::App::Runner, ListTool::App::Colorizer]
    expect(subject::COMMANDS).to eq commands
  end

  describe '.process' do
    let(:lister)  {ListTool::Lister.new}
    let(:printer) { ListTool::App::Printer }

    context 'success' do

      it 'gets command from argv' do
        expect(argv = []).to receive(:shift).with(no_args)
        allow(subject::COMMANDS).to receive(:each)
        subject.process(argv, lister)
      end

      context 'no command given' do
        it 'uses "h" command' do
          expect(argv = []).to receive(:<<).with('h')
          allow(subject::COMMANDS).to receive(:each)
          subject.process(argv, lister)
        end
      end

      it "passes command commands' .match? method" do
        ListTool::App::Commands::COMMANDS.each do |cmd|
          expect(cmd).to receive(:match?).with('some_command')
        end
        subject.process(['some_command'], lister)
      end

      it "executes matched command" do
        expect(ListTool::App::ShowListsCommand).to receive(:parse)
        expect(ListTool::App::ShowListsCommand).to receive(:execute)
        subject.process(['sl'], lister)
      end

      it "don't execute unmatched commands" do
        ListTool::App::Commands::COMMANDS.each do |cmd|
          expect(cmd).not_to receive(:parse) unless cmd == ListTool::App::AddListCommand
          expect(cmd).not_to receive(:execute) unless cmd == ListTool::App::AddListCommand
        end
        allow(ListTool::App::AddListCommand).to receive(:prase)
        allow(ListTool::App::AddListCommand).to receive(:execute)

        subject.process(['al', 'list_name'], lister)
      end

    end

    context 'failure' do

      context 'when first argument is not an array' do
        it 'raises ArgumentError' do
          expect{ subject.process 'not_an_array', lister, printer }.to raise_error(ArgumentError)
        end
      end

    end

  end


  describe '.help' do
    it 'returns a string' do
      expect(subject.help).to be_a String
    end

    it 'gets help messages from all commands' do
      ListTool::App::Commands::COMMANDS.each { |cmd| expect(cmd).to receive(:help).and_return("") }
      subject.help
    end
  end
end