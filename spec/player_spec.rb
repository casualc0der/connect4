require_relative '../lib/connect4/player'

RSpec.describe Player do
  context 'when first created' do
    it 'Should raise an error if no name supplied' do
      expect{ Player.new }.to raise_error(ArgumentError)
    end
    it 'Should raise an error if no disc supplied' do
      expect { Player.new('Edd') }.to raise_error(ArgumentError)
    end
    it 'Should save the players name' do
      player = Player.new('Edd', 'x')
      expect(player.name).to eq('Edd')
    end
    it 'Should save the players symbol' do
      player  = Player.new('Edd', 'x')
      expect(player.disc).to eq('x')
    end
    it 'Should reject the name if more than 50 chars' do
      expect { Player.new('x' * 51, 'x') }.to raise_error("Name should be 50 characters or less")
    end
    it 'Should reject the disc if more than one char' do
      expect { Player.new('Edd', 'xx') }. to raise_error("Use single character for disc")
    end
  end
  describe '#disc_check' do
    context 'when disc supplied matches player disc' do
      it 'returns true' do
        player = Player.new('Edd', 'o')
        expect(player.disc_check('o')).to be(true)
      end
    end
    context 'when disc supplied does not match player disc' do
      it 'returns false' do
        player = Player.new('Edd', 'o')
        expect(player.disc_check('x')).to be(false)
      end
    end
  end
end
