require 'spec_helper'
describe 'ispprotect' do
  context 'with default values for all parameters' do
    it { should contain_class('ispprotect') }
  end
end
