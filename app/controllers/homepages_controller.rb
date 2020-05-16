class HomepagesController < ApplicationController
  def index
    @spotlight  = Work.spotlight
    @top_movies = Work.top("movie", 10)
    @top_books  = Work.top("book", 10)
    @top_albums = Work.top("album", 10)
  end
end
