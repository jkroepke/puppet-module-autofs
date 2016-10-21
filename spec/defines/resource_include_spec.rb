require 'spec_helper'

describe 'autofs::include' do
  let(:title) { 'auto.include' }
  let(:facts) { { osfamily: 'RedHat', concat_basedir: '/mock_dir' } }

  describe 'testing class' do
    it { should_not raise_error }
    it do
      should contain_concat__fragment('auto.master/auto.include').
        with_content(%r{\+auto\.include})
    end
  end

  describe 'testing all parameters' do
    let(:params) { { mapfile: 'auto.foo', order: '5' } }
    it { should_not raise_error }
    it do
      should contain_concat__fragment('auto.master/auto.foo').
        with_content(%r{\+auto\.foo}).
        with_order('5')
    end
  end
end
