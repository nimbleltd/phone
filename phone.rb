#!/usr/bin/env ruby
require 'optparse'
require 'rubygems'
gem 'activerecord'
require 'sqlite3'
require 'active_record'
require 'bundler/setup'
require 'fastercsv'

  class Phone
    attr_accessor :file
    attr_accessor :headers

    CSVFILE = "/Users/happyDay/Downloads/nss-contact-info.csv"

    @name = ARGV[0]
    #year = ARGV[1]

    options = {}

    opt_parser = OptionParser.new do |opt|
      opt.banner = "Usage: opt_parser COMMAND [OPTIONS]"
      opt.separator  ""
      opt.separator  "Commands"
      opt.separator  "     -i <csv data file>, loads in contact data"
      opt.separator  "     -c, destroy's current data set"
      opt.separator  "     <name>, will print info of user"
      opt.separator  ""
      opt.separator  "Options"

      opt.on("-i","--in","\e[31m <data file> loads csv into database\e[0m") do |load|
        options[:load] = load
      end

      opt.on("-c","--clear","\e[30m clears current database\e[0m") do |clear|
        options[:clear] = clear
      end

      opt.on("-h","--help"," help") do
        puts opt_parser
      end
    end

    opt_parser.parse!

    def open_file
      filename = "/Users/happyDay/Downloads/nss-contact-info.csv"
      puts "Trying to open file with FasterCSV"
      @file = FasterCSV.open(filename, {:headers => true, :return_headers => true, :header_converters => :symbol})
      @headers = @file.readline
    end


    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => 'test.db'
    )

    # def initialize
    #   ActiveRecord::Schema.define do
    #     if create_table :users != NULL
    #       create_table :users do |table|
    #         table.column :firstname, :string
    #         table.column :lastname, :string
    #         table.column :phone, :string
    #         table.column :email, :string
    #         table.column :part_of_town, :string
    #         table.column :github, :string
    #       end
    #     end
    #   end
    # end

    class User < ActiveRecord::Base
    end

    # def enter_data_into_database
    # CSVFILE.open(file, "r").each do |line|
    #   num, firstname, lastname = line.strip.split(",")
    #   firstname = User.create(:firstname => firstname,
    #                           :lastname => lastname)
    # end
    # end

    User.create(:firstname => 'mike', :lastname => 'smith', :part_of_town => 'wrong_side_of_the_tracks')

    mike = User.where(:firstname => "mike").first

    puts mike.firstname

    puts mike.lastname

    puts mike.part_of_town

    # Users.destroy_all

    case ARGV[0]
    when "-i"
      puts "boobs #{@name}"
    when "stop"
      puts "call stop on options #{options.inspect}"
    when "restart"
      puts "call restart on options #{options.inspect}"
    when nil
      puts opt_parser
    end
end

bob = Phone.new