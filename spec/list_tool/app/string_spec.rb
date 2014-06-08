require_relative '../../spec_helper.rb'

describe String do

  describe '#colorize' do
    it 'colorizes string using given code' do
      expect('test'.colorize(31)).to eq "\x1B[31mtest\x1B[0m"
    end
  end

  describe '#red' do
    it 'calls #colorize with 31' do
      expect(string = 'test').to receive(:colorize).with(31)
      string.red
    end
  end

  describe '#green' do
    it 'calls #colorize with 32' do
      expect(string = 'test').to receive(:colorize).with(32)
      string.green
    end
  end

  describe '#blue' do
    it 'calls #colorize with 34' do
      expect(string = 'test').to receive(:colorize).with(34)
      string.blue
    end
  end

end