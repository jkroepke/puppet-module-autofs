require 'spec_helper'

describe 'Autofs::Config' do
  describe 'accepts any hash contains subhash' do
    [
      {},
      { section: { key: 'value' } },
      { section: { key: 0 } },
      { section: { key: 1000 } },
      { section: { key: true } },
      { section: { key: false } },
    ].each do |value|
      describe value.inspect do
        it { is_expected.to allow_value(value) }
      end
    end
  end

  describe 'rejects other values' do
    [
      [],
      'abc1',
      true,
      'atun1000',
      { section: 'value' },
      { section: { key: { key: 0 } } },
      { section: { key: [] } },
    ].each do |value|
      describe value.inspect do
        it { is_expected.not_to allow_value(value) }
      end
    end
  end
end
