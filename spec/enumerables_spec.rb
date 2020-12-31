require_relative '../lib/enumerables.rb'

describe Enumerable do
  describe '#my_each' do
    let(:arr) { %w(john david peter) }

    it 'returns enumerator if no block is given' do
      result = arr.my_each
      expect(result).to be_instance_of(Enumerator)
    end
  end
end
