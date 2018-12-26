require 'pry'

class MusicLibraryController
  attr_accessor :path, :music
  def initialize(path = "./db/mp3s")
    @path = path
    @music = MusicImporter.new(@path)
    @music.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    user_input = gets.chomp

    case user_input
    when "list songs"
      self.list_songs
    when "list artists"
      self.list_artists
    when "list genres"
      self.list_genres
    when "list artist"
      self.list_songs_by_artist
    when "list genre"
      self.list_songs_by_genre
    when "play song"
      self.play_song
    when "exit"
    else
      self.call
    end
  end

  def list_songs
    Song.all.sort_by{|x| x.name}.each_with_index {|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    Artist.all.sort_by{|x| x.name}.each_with_index {|artist, index| puts "#{index+1}. #{artist.name}"}
  end

  def list_genres
    Genre.all.sort_by{|x| x.name}.each_with_index {|genre, index| puts "#{index+1}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    artist = Artist.find_by_name(input)
    if artist != nil
      artist.songs.sort_by{|x| x.name}.each_with_index {|song, index| puts "#{index+1}. #{song.name} - #{song.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    genre = Genre.find_by_name(input)
    if genre != nil
      genre.songs.sort_by{|x| x.name}.each_with_index {|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.chomp
    input = user_input.to_i
    if input.between?(1,Song.all.length)
      song = Song.all.sort_by{|x| x.name}[input-1]
      puts("Playing #{song.name} by #{song.artist.name}")
    end
  end

  # def exit
  #   puts "good-bye"
  #   Song.destroy_all
  #   Artist.destroy_all
  #   Genre.destroy_all
  # end
end
