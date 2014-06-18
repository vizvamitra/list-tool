require_relative '../../spec_helper.rb'

describe ListTool::App::Printer do
  subject { ListTool::App::Printer }

  describe '.error' do
    it 'prints error message' do
      expect(subject).to receive(:puts).with( "\x1B[31mERROR\x1B[0m: some error\n" )
      subject.error(StandardError.new('some error'))
    end
  end


  describe '.print_items' do
    it 'prints list of items with indexes (starting with 1)' do
      expect(subject).to receive(:puts).with( "Printing \x1B[32mtestlist\x1B[0m:\n   1. item1\n   2. item2\n" )
      subject.print_items( {name: 'testlist', items: ['item1', 'item2']} )
    end
  end


  describe '.print_lists' do
    it 'prints list of lists with indexes (starting with 1)' do
      expect(subject).to receive(:puts).with( "Printing lists:\n   1. list1 (1)\n   2. list2 (2)\n" )
      subject.print_lists( {'list1' => 1, 'list2' => 2} )
    end
  end


  describe '.print_usage' do
    it 'gets help messages from commands' do
      allow( subject ).to receive(:puts)
      ListTool::App::Commands::COMMANDS.each do |cmd|
        expect(cmd).to receive(:help).and_return("")
      end
      subject.print_usage
    end

    it 'prints usage info' do
      allow( ListTool::App::Commands::COMMANDS ).to receive(:each)
      expect( subject ).to receive(:puts)
      subject.print_usage
    end
  end


  describe '.print_version' do
    it 'prints version of program' do
      expect( subject ).to receive(:puts).with("clt version #{ListTool::VERSION}")
      subject.print_version
    end
  end

end