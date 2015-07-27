require 'spec_helper'
describe 'profiles', :type => 'class' do

  context 'with defaults for all parameters' do
    it { should contain_class('profiles') }
  end
end
