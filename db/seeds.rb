# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "open-uri"
require "json"
Bookmark.destroy_all
Movie.destroy_all
List.destroy_all


url = "http://tmdb.lewagon.com/movie/top_rated"

20.times do |i|
  movies = JSON.parse(URI.open("#{url}?page=#{i + 1}").read)["results"]
  movies.each do |movie|
    base_poster_url = "https://image.tmdb.org/t/p/original"
    Movie.create(
      title: movie["title"],
      overview: movie["overview"],
      poster_url: "#{base_poster_url}#{movie["backdrop_path"]}",
      rating: movie["vote_average"]
    )
  end
end

List.create(name: "Romance")
List.create(name: "Action")
List.create(name: "Comedy")

Bookmark.create(comment: "Great movie", movie: Movie.first, list: List.first)
Bookmark.create(comment: "Super movie", movie: Movie.second, list: List.first)
Bookmark.create(comment: "Superb movie", movie: Movie.third, list: List.first)
Bookmark.create(comment: "Superb movie", movie: Movie.fourth, list: List.second)
Bookmark.create(comment: "Great movie", movie: Movie.fifth, list: List.second)
Bookmark.create(comment: "Great movie", movie: Movie.fifth, list: List.third)
Bookmark.create(comment: "Best ever movie", movie: Movie.last, list: List.third)
