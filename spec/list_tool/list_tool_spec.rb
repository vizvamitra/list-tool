require_relative '../spec_helper.rb'

describe ListTool::ListTool do

  describe '#initialize' do

    context 'path to datafile given' do
      it 'stores path to datafile' do
        lt = ListTool::ListTool.new('path_to_datafile')
        expect(lt.data_path).to eq 'path_to_datafile'
      end
    end

  end

end