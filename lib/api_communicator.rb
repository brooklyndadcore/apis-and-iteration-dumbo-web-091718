require 'rest-client'
require 'json'
require 'pry'

def helper_movie(hash, char)
  hash['results'].each do |person|
    if person["name"].downcase == char.downcase
      return person["films"]
    end
  end
  return nil
end

def get_character_movies_from_api(character, url)
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)

  movie_arr = helper_movie(response_hash, character)

  films_array = []
  if movie_arr == nil
    next_page = response_hash["next"]
    if next_page
      return get_character_movies_from_api(character, next_page)
    end
  else
    movie_arr.each do |movie|
      movie_string = RestClient.get(movie)
      films_array << movie_hash = JSON.parse(movie_string)
    end
  end

  return films_array
end


def print_movies(films_hash)
  films_hash.each do |movie|
    puts movie["title"]
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character, 'http://www.swapi.co/api/people/')
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
