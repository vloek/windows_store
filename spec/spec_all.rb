require 'rspec'
require './lib/windows_store'

describe 'Spec all functionality of gem' do 
  it 'works!' do
    (WindowsStore.verify! File.read(File.dirname(__FILE__) + '/example_receipt.xml')) == true
  end
end