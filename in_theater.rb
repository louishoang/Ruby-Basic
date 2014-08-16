require 'json'
require 'pry'

movie_data = JSON.parse(File.read('in_theaters.json'))


def get_movie_title(list)
  movie_list = list["movies"]

  movie_list.each do |movie|
    puts "#{movie["title"]}"
  end
end

def get_MPAA(list)
  movie_list = list["movies"]

  movie_list.each do |movie|
    puts "#{movie["title"]} (#{movie["mpaa_rating"]})"
  end
end

def get_avg_score(list)
  movie_list = list["movies"]

  movie_list.each do |movie|
    avg = (movie["ratings"]["critics_score"] + movie["ratings"]["audience_score"]) / 2
    puts "#{avg} - #{movie["title"]} (#{movie["mpaa_rating"]})"
  end
end

def get_cast_members(list)
  movie_list = list["movies"]

  movie_list.each do |movie|
    cast_list = movie["abridged_cast"].first(3)
    #binding.pry
    avg = (movie["ratings"]["critics_score"] + movie["ratings"]["audience_score"]) / 2
      print "#{avg} - #{movie["title"]} (#{movie["mpaa_rating"]}) starring "

      comma_count = 0
      cast_list.each do |cast|

        if comma_count == cast_list.length - 1
          print "#{cast["name"]} "
        else
          print "#{cast["name"]}, "
        end

        comma_count += 1
        #binding.pry
      end
      puts
  end
end

def get_highest_rating(list)

  sorted_by_rating = list["movies"].sort_by do |movie|
  (movie["ratings"]["critics_score"] + movie["ratings"]["audience_score"]) / 2
  end

  sorted_by_rating.reverse!
  sorted_by_rating.each do |mov|
    print "#{((mov["ratings"]["critics_score"]) + (mov["ratings"]["audience_score"])) / 2}"
    print "- #{mov["title"]} (#{mov["mpaa_rating"]})"
    print " starring "
    comma_count = 0
    (mov["abridged_cast"].first(3)).each do |name|
        if comma_count == (mov["abridged_cast"].first(3)).length - 1
          print "#{name["name"]}."
        else
          print "#{name["name"]}, "
        end
        comma_count += 1
    end
    puts
  end
end

############################
#Uncomment the following method to check each part
#of the assignment.
#Get_highest_rating is defaut.

# get_movie_title(movie_data)
# get_MPAA(movie_data)
# get_avg_score(movie_data)
# get_cast_members(movie_data)
get_highest_rating(movie_data)

############################
