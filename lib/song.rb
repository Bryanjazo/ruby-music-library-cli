require "pry"
class Song
  extend Concerns::Findable

attr_accessor :name
attr_reader :artist, :genre

@@all = []

def initialize(name, artist = nil, genre = nil)
  @name = name
  self.artist= artist if artist!=nil
  self.genre= genre if genre!=nil
  end

def artist=(artist)
  @artist = artist
  artist.add_song(self)
  end

  def genre=(genre)
   @genre = genre
   genre.songs << self unless genre.songs.include?(self)
 end


def self.all
  @@all
end

def self.destroy_all
  all.clear
end


def save
  self.class.all << self
end

def self.create(name)
  song = new(name)
  song.save
  song
end

def self.new_from_filename(filename)
  parts = filename.gsub(".mp3", "").split(" - ")
  artist = Artist.find_or_create_by_name(parts[0])
  genre = Genre.find_or_create_by_name(parts[2])
  self.new(parts[1], artist, genre)
end

def self.create_from_filename(filename)
  song = self.new_from_filename(filename)
  song.save
end


end
