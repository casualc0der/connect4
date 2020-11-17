class Player
  attr_reader :name, :disc
  def initialize(name, disc)
    @name = name
    @disc = disc

  end
end

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
  end
end
