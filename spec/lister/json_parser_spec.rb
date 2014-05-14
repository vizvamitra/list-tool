require_relative '../spec_helper.rb'

describe Lister::JsonParser do

  describe '.parse' do
    it 'parses json' do
      json = "{\"test\":0}"
      allow(JSON).to receive(:parse).with(json).and_return({'test'=>0})

      expect( Lister::JsonParser.parse(json) ).to eq({"test" => 0})
    end
  end 

end