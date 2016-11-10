require 'spec_helper'

describe EasyEncoding::Huffman do
  context 'creating' do
    context 'when argument is ' do
      context 'frequencies' do
        context 'frequencies should be' do
          frequencies = { a: 0.2, b: 0.3, c: 0.5 }
          coding = EasyEncoding::Huffman.new(frequencies)

          context 'correct' do
            it { expect(coding.frequencies).to eq frequencies }
          end

          context 'sorted' do
            it { expect(coding.frequencies.values).to eq frequencies.values.sort.reverse }
          end
        end

        context 'frequencies summ should eq 1' do
          it do
            expect { EasyEncoding::Huffman.new(a: 0.2, b: 0.3, c: 0.6) }
              .to raise_error 'summ of frequencies should eq 1'
          end
        end

        context 'argument should be a string or a hash' do
          it { expect { EasyEncoding::Huffman.new(20) }.to raise_error 'you must provide a hash or a string' }
        end
      end

      context 'string' do
        coding = EasyEncoding::Huffman.new('test')

        context 'input should be correct' do
          it { expect(coding.input).to eq 'test' }
        end

        context 'should have frequencies' do
          it { expect(coding.frequencies).to eq(t: 0.5, s: 0.25, e: 0.25) }
        end
      end
    end
  end

  context 'coding' do
    context 'should have' do
      coding = EasyEncoding::Huffman.new('test')
      context 'right char codes' do
        it { expect(coding.char_codes).to eq(t: '1', e: '00', s: '01') }
      end

      context 'right root node' do
        it { expect(coding.root.frequency).to eq 1 }
        it { expect(coding.root.symbol).to eq '' }
      end
    end
  end
end
