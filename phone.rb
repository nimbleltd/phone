#!/usr/bin/ruby
require 'optparse'
require 'rubygems'
gem 'activerecord'
require 'sqlite3'
require 'active_record'


name = ARGV[0]
#year = ARGV[1]

options = {}

opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: opt_parser COMMAND [OPTIONS]"
  opt.separator  ""
  opt.separator  "Commands"
  opt.separator  "     -i <csv data file>, loads in contact data"
  opt.separator  "     -c, clears current data set"
  opt.separator  "     <name>, will print info of user"
  opt.separator  ""
  opt.separator  "Options"

  opt.on("-i","--in","<data file> loads csv into database") do |load|
    options[:load] = load
  end

  opt.on("-c","--clear","clears current database") do |clear|
    options[:clear] = clear
  end

  opt.on("-h","--help","help") do
    puts opt_parser
  end
end

opt_parser.parse!

# ActiveRecord::Base.establish_connection(
#   :adapter => 'sqlite3',
#   :database => 'test.db'
# )

# ActiveRecord::Schema.define do
#   create_table :users do |table|
#   table.column :firstname, :string
#   table.column :lastname, :string
#   table.column :phone, :string
#   table.column :email, :string
#   table.column :part_of_town, :string
#   table.column :github, :string
#   end
# end

# class User < ActiveRecord::Base
# end

case ARGV[0]
when "start"
  puts "call start on options #{options.inspect}"
when "stop"
  puts "call stop on options #{options.inspect}"
when "restart"
  puts "call restart on options #{options.inspect}"
else
  puts opt_parser
end