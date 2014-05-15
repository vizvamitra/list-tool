require_relative '../spec_helper.rb'

describe ListTool::Item do
  let (:item){ListTool::Item.new(Factory.item)}
  
  describe '#initialize' do

    context 'hash given' do
      context 'success' do
        it 'stores text' do
          expect(item.text).to eq 'item1'
        end
      end

      context 'failure' do
        it 'raises ArgumentError' do
          expect{ ListTool::Item.new({"text" => 123}) }.to raise_error(ArgumentError)
        end
      end
    end

    context 'string given' do
      it 'stores text' do
        expect(ListTool::Item.new('text').text).to eq 'text'
      end
    end

    context 'wrong argument given' do
      it 'raises ArgumentError' do
        expect{ListTool::Item.new(123)}.to raise_error(ArgumentError)
      end
    end

  end

  describe '#to_json' do
    it 'returns correct json' do
      expect(item.to_json).to eq "{\"text\":\"item1\"}"
    end
  end

end