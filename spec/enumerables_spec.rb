require_relative '../lib/enumerables.rb'

describe Enumerable do
  let(:strings) { %w(john david peter) }
  let(:numbers) { [1, 2, 3] }

  describe '#my_each' do
    context 'when no block is given' do
      it 'returns enumerator' do
        result = strings.my_each
        expect(result).to be_instance_of(Enumerator)
      end
    end

    context 'when a block is given' do
      it 'returns an array' do
        result = strings.my_each { |item| item }
        expect(result).to be_instance_of(Array)
      end

      it 'calls the given block once for each element and returns array itself' do
        result = numbers.my_each { |number| number * 2 }
        expect(result).to eq([1, 2, 3])
      end

      it 'calls the given block once for each element, passing that element as a parameter' do
        arr = []
        numbers.my_each { |number| arr << number * 2 }
        expect(arr).to eq([2, 4, 6])
      end
    end
  end

  describe '#my_each_with_index' do
    context 'when no block is given' do
      it 'returns enumerator' do
        result = strings.my_each_with_index
        expect(result).to be_instance_of(Enumerator)
      end
    end

    context 'when a block is given' do
      it 'returns array itself' do
        result = numbers.my_each_with_index { |number| number * 2 }
        expect(result).to eq([1, 2, 3])
      end

      it 'Calls block with two arguments, the item and its index, for each item in enum' do
        hash = Hash.new
        strings.each_with_index { |item, index| hash[item] = index }
        expect(hash).to eq( { "john"=>0, "david"=>1, "peter"=>2 } )
      end
    end
  end

  describe '#my_all?' do
    it 'returns true if the block never returns false or nil' do
      result = strings.all? { |word| word.length >= 4 }
      expect(result).to be(true)
    end

    context 'when no block is given' do
      it 'returns true when none of the collection members are false or nil' do
        result = [nil, true, 99].all?
        expect(result).to_not be(true)
      end

      context 'when argument is provided' do
        it 'if pattern is supplied, returns whether pattern === element for every collection member' do
          result = %w[ant bear cat].all?(/t/)
          expect(result).to_not be(true)
        end

        it 'returns true if object type in argument is true for all elements' do
          result = strings.all?(Numeric)
          expect(result).to_not be(true)
        end
      end
    end
  end
end
