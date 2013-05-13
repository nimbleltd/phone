#!/usr/bin/ruby

require 'rubygems'
gem 'activerecord'

require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'test.db'
)

class User < ActiveRecord::Base
  has_many :problems
end

class Problem < ActiveRecord::Base
  belongs_to :user
end

def show_single_item
  pr = Problem.find(:first)
  puts "showing first problem from the db below", pr.desc
end

# def show_all_items
#   pr = Problem.find(:all)
#   puts "showing all problems from the db below"

#   pr.each do |a|
#     puts a.desc
#   end
# end

# def check_has_many
#   user = User.find(:first)
#   puts user.problems.first.desc
# end

# run some methods
show_single_item  # works
#show_all_items    # works
#check_has_many    # not working
