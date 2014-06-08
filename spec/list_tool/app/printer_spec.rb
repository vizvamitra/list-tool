require_relative '../../spec_helper.rb'

describe ListTool::App::Printer do
  subject { ListTool::App::Printer }

  describe '.error' do
    it 'prints error message' do
      expect(subject).to receive(:puts).with( "#{"ERROR".red}: some error\n" )
      subject.error(StandardError.new('some error'))
    end
  end


  describe '.print_items' do
    it 'prints list of items with indexes (starting with 1)' do
      expect(subject).to receive(:puts).with( "Printing #{'testlist'.green}:\n   1. item1\n   2. item2\n" )
      subject.print_items( {name: 'testlist', items: ['item1', 'item2']} )
    end
  end


  describe '.print_lists' do
    it 'prints list of lists with indexes (starting with 1)' do
      expect(subject).to receive(:puts).with( "Printing lists:\n   1. list1 (1)\n   2. list2 (2)\n" )
      subject.print_lists( {'list1' => 1, 'list2' => 2} )
    end
  end
end