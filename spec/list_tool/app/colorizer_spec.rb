require_relative '../../spec_helper.rb'

describe ListTool::App::Colorizer do

  subject { ListTool::App::Colorizer }

  describe '#colorize' do
    it 'colorizes string using given code' do
      expect(subject.colorize('test', 31)).to eq "\x1B[31mtest\x1B[0m"
    end
  end

  describe '::red' do
    it 'calls ::colorize with 31' do
      expect(subject).to receive(:colorize).with('test', 31)
      subject.red('test')
    end
  end

  describe '::green' do
    it 'calls ::colorize with 32' do
      expect(subject).to receive(:colorize).with('test', 32)
      subject.green('test')
    end
  end

  describe '::blue' do
    it 'calls ::colorize with 34' do
      expect(subject).to receive(:colorize).with('test', 34)
      subject.blue('test')
    end
  end

end