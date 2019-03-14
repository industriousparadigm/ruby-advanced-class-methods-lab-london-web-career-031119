require "pry"

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    @@all << Song.new
    @@all.last
  end

  def self.new_by_name(name)
    song = Song.new
    song.name = name
    song
  end

  def self.create_by_name(name)
    song = Song.new
    song.name = name
    @@all << song
    @@all.last
  end

  def self.find_by_name(name)
    @@all.find { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    # binding.pry
    result = Song.find_by_name(name)
    result.class == Song ? result : Song.create_by_name(name)
  end

  def self.alphabetical
    @@all.sort_by { |song| song.name }
  end

  def self.new_from_filename(filename_str)
    parsed_name = filename_str.split(/[-.]/)
    new_song_name = parsed_name[1].strip
    new_artist_name = parsed_name[0].strip

    new_song = Song.create_by_name(new_song_name)
    new_song.artist_name = new_artist_name

    new_song
  end

  def self.create_from_filename(filename_str)
    @@all << Song.new_from_filename(filename_str)
    @@all.last
  end

  def self.destroy_all
    @@all = []
  end

end
