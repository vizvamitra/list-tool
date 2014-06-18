require_relative '../../../spec_helper.rb'

describe ListTool::App::Command do
  subject { ListTool::App::Command }

  describe '::parse_number' do
    context 'success' do
      it "returns an integer" do
        expect( subject.parse_number("2", "list") ).to eq 1
      end
    end

    context 'failure' do

      it 'injects given number name into error message' do
        expect{ subject.parse_number("not_an_int", "smth") }.to raise_error(ArgumentError, /smth/)
      end

      context 'when list number is not a integer' do
        it 'raises ArgumentError' do
          expect{ subject.parse_number("not_an_int", "item") }.to raise_error(ArgumentError)
        end
      end

      context 'when list number is less than 1' do
        it 'raises ArgumentError' do
          expect{ subject.parse_number("-1", "list") }.to raise_error( ArgumentError)
        end
      end
    end
  end


  describe '::parse_item_number' do
    it 'calls ::parse_number with given string and "item"' do
      expect(subject).to receive(:parse_number).with("2", "item")
      subject.parse_item_number("2")
    end
  end

  describe '::parse_item_number!' do
    it 'calls ::parse_item_number with given string' do
      expect(subject).to receive(:parse_item_number).with("2")
      subject.parse_item_number!("2")
    end

    it 'raises ArgumentError if number == nil' do
      expect{ subject.parse_item_number!(nil) }.to raise_error(ArgumentError, /item number/)
    end
  end


  describe '::parse_list_number' do
    it 'calls ::parse_number with given string and "list"' do
      expect(subject).to receive(:parse_number).with("2", "list")
      subject.parse_list_number("2")
    end
  end

  describe '::parse_list_number!' do
    it 'calls ::parse_list_number with given string' do
      expect(subject).to receive(:parse_list_number).with("2")
      subject.parse_list_number!("2")
    end

    it 'raises ArgumentError if number == nil' do
      expect{ subject.parse_list_number!(nil) }.to raise_error(ArgumentError, /list number/)
    end
  end


  describe '::ensure_existence_of' do
    it 'raises error if given argument is nil' do
      expect{ subject.ensure_existence_of("value" => nil) }.to raise_error(ArgumentError)
    end

    it 'raises error if any of given hash values is nil' do
      expect{ subject.ensure_existence_of("value1" => "not_nil", "value2" => nil) }.to raise_error(ArgumentError)
    end

    it 'inserts key name to exception message' do
      expect{ subject.ensure_existence_of("value1" => nil) }.to raise_error(ArgumentError, /value1/)
    end
  end


  describe '::fail_if_not_an_array' do
    context 'when argument is an array' do
      it 'does nothing' do
        expect{ subject.fail_if_not_an_array([]) }.not_to raise_error
      end
    end

    context 'when argument is not an array' do
      it 'raises ArgumentError' do
        expect{ subject.fail_if_not_an_array("not_an_array") }.to raise_error(ArgumentError)
      end
    end
  end

end
