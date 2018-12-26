class Genre
  attr_accessor :name, :songs
  @@all = []

  extend Concerns::Findable

  def initialize(name)
    @name = name
    @songs = []
  end

  def artists
    @songs.map{|x| x.artist}.compact.uniq
  end

  def save
    @@all << self
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end
end
# class Genre
#   attr_accessor :name, :songs, :artists
#
#   extend Concerns::Findable
#
#   @@all = []
#
#   def initialize(name)
#     @name = name
#     @songs = []
#     @artists = []
#   end
#
#   def self.create(name)
#     genre = Genre.new(name)
#     genre.save
#     genre
#   end
#
#   def add_song(song)
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
