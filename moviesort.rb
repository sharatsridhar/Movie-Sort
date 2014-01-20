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
def load_data_pop
	moviedb = File.open("/Users/sharat/mydev/u.data", "r")
	moviedb.each do |line|
		#user_id = line.split("\t")[0]
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
	count = 0
	expression = "Most popular movies"
	poplistsize = Movies.movies_db.length
	poplist = Movies.movies_db.sort_by { |movie, popularity| popularity }.reverse
	poplist.each do |movie, rating|
		
		if count < 10
			puts expression	+ ": #{movie}"
		end
		if count > poplistsize - 11
			expression = "Least popular movies"
			puts expression + ": #{movie}"
		end
		count += 1
	end
end
class Users
	attr_accessor :user_id, :rating, :count
	@@users_db = Hash.new
	def self.users_db 
		@@users_db
	end	

	def self.users_db=(hash=Hash.new)
		@@users_db = hash
	end

	def self.create_with_attributes(user_id, rating, count)
		user = self.new
		user.count = count
		#movie.movie_id = movie_id
		user.rating = rating
		@@users_db[user_id] = user
		return user
	end
	def self.update_attribute(user_id, rating, count)
		if @@users_db.include? user_id
			@@users_db[user_id].rating += rating
			@@users_db[user_id].count += 1
		else 
			puts "not found"
		end
	end
	def initialize
	end
end

def load_data_sim
	count = 1
	userdb = File.open("/Users/sharat/mydev/u.data", "r")
	userdb.each do |line|
		user_id = line.split("\t")[0]
		#movie_id = line.split("\t")[1]
		movie_rating = (line.split("\t")[2])
		if Users.users_db.include? user_id
			Users.update_attribute(user_id, movie_rating.to_i, count)
		else
			Users.create_with_attributes(user_id, movie_rating.to_i, count)
		end
	end
	Users.users_db.each do |key, value|
	avgrating = value.rating.to_f / value.count.to_f
	Users.users_db[key] = avgrating.round
	end
end

def similarity(user1, user2)
	count = 0
	value = 0
	#simhash = Hash.new
	similarity = (Users.users_db[user1.to_s] - Users.users_db[user2.to_s]).abs
	#puts similarity
	case similarity
		when 0
			#simhash[user1] = Hash.new
	#		simhash[user2] = 5#[user2] = 5
			value = 5
		when 1
			#simhash[user1] = Hash.new
	#		simhash[user2] = 4#[user2] = 4
			value = 4
		when 2
			#simhash[user1] = Hash.new
	#		simhash[user2] = 3#[user2] = 3
			value = 3
		when 3
			#simhash[user1] = Hash.new
	#		simhash[user2] = 2#[user2] = 2
			value = 2
		when 4
			#simhash[user1] = Hash.new
	#		simhash[user2] = 1#[user2] = 1
			value = 1
		else
			puts "ERROR"
		end
	return value
end
def simlist(chosen_user)
	count = 0
	temphash = Hash.new
	Users.users_db.each do |user, avgrating|
		temp = similarity(chosen_user, user)
		temphash[user] = temp
	end
	simarray = temphash.sort_by { |compared,simscore| simscore }.reverse
	simarraysize = simarray.length
	simarray.each do |compared, simscore|
		if count < 10
			puts "Most similar to chosen(#{chosen_user}): #{compared}"
			#count += 1
		end
		if count > simarraysize - 11
			puts  "Least similar to chosen(#{chosen_user}): #{compared}"
			#count += 1
		end
		count += 1
	end
end

puts "Enter 1 for popularity list or 2 for similarity list"
choice = gets.chomp
if choice == 1.to_s
	load_data_pop
	popularitylist
elsif choice == 2.to_s
	load_data_sim
	puts "Choose the user you want to be compared to"
	user = gets.chomp
	if Users.users_db.include? user
		simlist(user)
	else
		puts "User doesn't exist in database!"
	end
else
	puts "Bad Input!"
end
	
#load_data_pop
#popularitylist
#load_data_sim
#simlist(196)
