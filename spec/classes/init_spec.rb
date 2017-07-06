require 'spec_helper'
describe 'geth' do
  context 'with default values for all parameters' do
    it { should contain_class('geth') }
  end
end
