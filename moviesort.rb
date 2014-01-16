class Movies
	attr_accessor :rating, :movie_id
	@@movies_db = Hash.new
	@@count = 0
	
	def self.movies_db 
		@@movies_db
	end	

	def self.movies_db=(hash=Hash.new)
		@@movies_db = hash
	end

	def self.create_with_attributes(movie_id, rating)
		movie = self.new
		#movie.movie_id = movie_id
		movie.rating = rating
		@@movies_db[movie_id] = movie
		return movie
	end

	def self.update_attribute(movie_id, rating)
		if @@movies_db.include? movie_id
			@@movies_db[movie_id].rating += rating
		else 
			puts "not found"
		end
		#rating += rating
		#return rating
	end

	def initialize
		#puts "Movie has been added"
		#puts @@count += 1
	end

end
def popularity
	moviedb = File.open("/Users/sharat/movie-data/u.data", "r")
	moviedb.each do |line|
		movie_id = line.split("\t")[1]
		movie_rating = (line.split("\t")[2])
		if Movies.movies_db.include? movie_id
			Movies.update_attribute(movie_id, movie_rating.to_i)
		else
			#Movies.movies_db[movie_id] = movie_rating
			Movies.create_with_attributes(movie_id, movie_rating.to_i)
		end
	end
end
def popularitylist
	Movies.movies_db.each do |key, value|
		Movies.movies_db[key] = value.rating
	end
	poplist = Movies.movies_db.sort_by { |movie, popularity| popularity }.reverse
	poplist.each do |movie, rating| 
		puts "#{movie}: #{rating}"
	end
end

def similarity
	moviedb = File.open("/Users/sharat/Downloads/moviedbfull.txt", "r")
	moviedb.each do |line|
		user_id = line.split("\t")[0]
		movie_id = line.split("\t")[1]
		movie_rating = (line.split("\t")[2])
	end
end

class Users
attr_accessor :user_id, :rating, :movie_id

end
popularity
popularitylist