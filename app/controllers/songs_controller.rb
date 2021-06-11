class SongsController < ApplicationController
  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end
  get '/songs/new' do
    @genres = Genre.all
    @artists = Artist.all
    erb :'/songs/new'
  end
  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @genres = @song.song_genres.collect do | song_genre |
      Genre.find(song_genre.genre_id) 
    end
    erb :'/songs/show'
  end
  get '/songs/:slug/edit' do

  end
  post '/songs' do
    binding.pry
    if !params[:genre][:name].empty?
      @genre = Genre.create(params[:genre])
      params[:genres] << @genre.id
    end
    if params[:song][:artist_id].nil?
      @artist = Artist.create(params[:artist])
      params[:song][:artist_id] = @artist.id
    end
    @song = Song.create(params[:song])

    params[:genres].each do | value |
      SongGenre.create(song_id: @song.id, genre_id: value)
      
    end
    
    flash[:message] = "Successfully created song."
    redirect to("/songs/#{@song.slug}")
  end

end