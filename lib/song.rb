class Song
  attr_accessor :name, :artist, :genre
  @@all = []

  extend Concerns::Findable

  def initialize(name, artist=nil, genre=nil)
    @name = name
    artist.add_song(self) if artist != nil
    if genre != nil
      self.genre = genre
      #artist.genres << @genre unless artist.genres.include?(@genre)
      #genre.artists << @artist unless genre.artists.include?(@artist)
    end
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def save
    @@all << self
  end

  def self.new_from_filename(name)
    info = name.split(" - ")
    artist = Artist.find_or_create_by_name(info[0])
    genre = Genre.find_or_create_by_name(info[2].gsub(".mp3",""))
    Song.new(info[1], artist, genre) unless Song.find_by_name(info[1])
  end

  def self.create_from_filename(name)
    song = self.new_from_filename(name)
    @@all << song if song != false
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end


end




#   class Song
#   attr_accessor :name, :artist, :genre
#
#   extend Concerns::Findable
#
#   @@all = []
#
#   def initialize(name, artist = nil, genre = nil)
#     @name = name
#     if artist != nil
#       self.artist = artist
#
#     end
#
#     if genre != nil
#       self.genre = genre
#     end
#
#     if artist != nil && genre != nil
#       if !self.genre.artists.include?(artist)
#         self.genre.artists << @artist
#       end
#       if !self.artist.genres.include?(genre)
#         self.artist.genres << @genre
#       end
#     end
#   end
#
#   def genre=(genre)
#     @genre = genre
#     @genre.add_song(self)
#   end
#
#   def artist=(artist)
#     @artist = artist
#     @artist.add_song(self)
#   end
#
#   def self.create(name)
#     song = Song.new(name)
#     song.save
#     song
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
#
#   def self.new_from_filename(name)
#     song = MusicImporter.new(name)
#     song.import
#   end
#
#   def self.create_from_filename(name)
#     song = self.new_from_filename(name)
#     @@all << song
#   end
#
# end
