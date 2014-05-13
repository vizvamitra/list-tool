require 'json'

class Factory

  def self.blank_data
    {'lists'=>[]}
  end

  def self.raw_data
    File.read(File.join('spec', 'fixtures', 'data.json'))
  end

  def self.json
    data.to_json
  end

  def self.data
    JSON.parse raw_data
  end

  def self.list
    data['lists'][0]
  end

  def self.blank_list
    data['lists'][1]
  end

  def self.item
    list['items'][0]
  end

end