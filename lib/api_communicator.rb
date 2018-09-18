require 'rest-client'
require 'json'
require 'pry'

def helper_movie(hash, char)
  hash.each do |k, v|
    if k == "results"
      v.each do |person|
        if person["name"].downcase == char.downcase
          return person["films"]
        end
      end
    end
  end
end

def get_character_movies_from_api(character)
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  movie_arr = helper_movie(response_hash, character)

  films_array = []
  movie_arr.each do |movie|
    movie_string = RestClient.get(movie)
    films_array << movie_hash = JSON.parse(movie_string)
  end

  return films_array
end


def print_movies(films_hash)
  films_hash.each do |movie|
    puts movie["title"]
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
