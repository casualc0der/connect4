class Player
  attr_reader :name, :disc

  def initialize(name, disc)
    raise 'Name should be 50 characters or less' if name.length > 50
    raise 'Use single character for disc' if disc.length > 1

    @name = name
    @disc = disc
  end

  def disc_check(disc_to_check)
    disc_to_check == disc
  end
end
