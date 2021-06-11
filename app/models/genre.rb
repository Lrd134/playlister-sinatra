class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs
  def slug
    self.name.split(" ").join("-").downcase
  end
  def self.deslugify(slug)
    slug.split("-").map {|s| s.capitalize}.join(" ")
  end
  def self.find_by_slug(slug)
    self.find_by_name(self.deslugify(slug))
  end
end