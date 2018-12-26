class Artist
  attr_accessor :name, :songs
  @@all = []

  extend Concerns::Findable

  def initialize(name)
    @name = name
    @songs = []
  end

  def genres
    @songs.map{|x| x.genre}.compact.uniq
  end

  def save
    @@all << self
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.artist = self if song.artist == nil
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end
end



# class Artist
#   attr_accessor :name, :songs, :genres
#
#   extend Concerns::Findable
#
#   @@all = []
#
#   def initialize(name)
#     @name = name
#     @songs = []
#     @genres = []
#   end
#
#   def self.create(name)
#     artist = Artist.new(name)
#     artist.save
#     artist
#   end
#
#   def add_song(song)
#     if song.artist == nil
#       song.artist = self
#     end
#     if !@songs.include?(song)
#       @songs << song
#     end
#   end
#
#   def save
#     @@all << self
#   end
#
#   def self.all
#     @@all
#   end
#
#   def self.destroy_all
#     @@all.clear
#   end
# end
