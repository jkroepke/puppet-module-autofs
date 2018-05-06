require 'spec_helper'

describe 'autofs::include' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:title) { 'auto.include' }

      describe 'testing class' do
        it { is_expected.not_to raise_error }
        it do
          is_expected.to contain_concat__fragment('auto.master/auto.include')
            .with_content(%r{\+auto\.include})
        end
      end

      describe 'testing all parameters' do
        let(:params) { { mapfile: 'auto.foo', order: '5' } }

        it { is_expected.not_to raise_error }
        it do
          is_expected.to contain_concat__fragment('auto.master/auto.foo')
            .with_content(%r{\+auto\.foo})
            .with_order('5')
        end
      end
    end
  end
end
