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
    attr_accessor :name


    CSVFILE = "/Users/happyDay/Downloads/nss-contact-info.csv"

    def user_input
      ARGV[0]
    end
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
      opt.on("-all","--all"," all") do
        puts opt_parser
      end

    end


    opt_parser.parse!

    def initialize
      open_file
      # puts "data file initialized..."
    end

    def open_file
      filename = "/Users/happyDay/Downloads/nss-contact-info.csv"
      # puts "Trying to open file with FasterCSV"
      @file = FasterCSV.open(filename, {:headers => true, :return_headers => true, :header_converters => :symbol})
      @headers = @file.readline
    end

    def print_first_name
      @file.each do |line|
        puts "#{line[:first_name]} #{line[:last_name]} #{line[:phone]}"
      end
    end

    def print_last_name
      @file.each do |line|
        puts line[:last_name]
      end
    end

    def print_part_of_town
      @file.each do |line|
        puts line[:part_of_town]
      end
    end

    def print_phone
      @file.each do |line|
        original_phone = line[:phone]
        clean = original_phone.gsub(".","-")
        puts clean
      end
    end

    def print_user_info
      unless user_input.nil?
        @file.each do |line|
          clean_phone = line[:phone].gsub(".","-")
          result = "\n==================\e[47m\nName:   #{line[:first_name]} #{line[:last_name]}\e[0m\nEmail:  #{line[:email]}\n\e[47mPhone:  #{clean_phone}\e[0m\nGithub: #{line[:github]}\n\e[47mTown:   #{line[:part_of_town]}\e[0m\n\n"

          # [line[:first_name], line[:last_name], line[:part_of_town]].any? { |contact_data| contact_data.downcase.include?(user_input.downcase) }

          # [:first_name, :last_name, :part_of_town].any? { |contact_data| line[contact_data].downcase.include?(user_input.downcase) }

          # if user_input != 'all' && line[:first_name].downcase.include?(user_input.downcase) || line[:last_name].downcase.include?(user_input.downcase) || line[:part_of_town].downcase.include?(user_input.downcase)

          if user_input != 'all' && user_input_matches?(line, :first_name, :last_name, :part_of_town)

            puts "\nPhone Results#{result}"
          # elsif i > 25
          #   puts "\e[31m***   Unable to find #{user_input}, please check spelling.   ***\e[0m"
          elsif user_input.downcase == "all"
            puts result
          end
        end
      end
    end

    def user_input_matches?(line, *field_types)
      field_types.any? { |contact_data| line[contact_data].downcase.include?(user_input.downcase) }
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

    # User.create(:firstname => 'mike', :lastname => 'smith', :part_of_town => 'wrong_side_of_the_tracks')

    # mike = User.where(:firstname => "mike").first

    # puts mike.firstname

    # puts mike.lastname

    # puts mike.part_of_town

    # Users.destroy_all

    case ARGV[0]
    when "-h"
      puts opt_parser
    when "-all"
      puts "\n==================\e[47m\nName:   #{line[:first_name]} #{line[:last_name]}\e[0m\nEmail:  #{line[:email]}\n\e[47mPhone:  #{clean_phone}\e[0m\nGithub: #{line[:github]}\n\e[47mTown:   #{line[:part_of_town]}\e[0m"
    when "restart"
      puts "call restart on options #{options.inspect}"
    when nil
      puts opt_parser
    end
end

phone = Phone.new
# phone.print_first_name
# phone.file.rewind
# phone.print_phone
# phone.file.rewind
# phone.print_last_name
# phone.file.rewind
phone.print_user_info