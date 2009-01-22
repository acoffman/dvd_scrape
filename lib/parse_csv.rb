require 'rubygems'
require 'csv'
require 'db_module.rb'

#connect to the SQL database
DB_Functions.connect

class Parser

	def initialize(filename)
		@filename = filename
	end

	def parse
		puts "Parsing #{@filename.split("/").last} and saving entries to the databse."
		CSV::Reader.parse(File.open(@filename,'rb')) do |curr_row|
			cur_dvd = DB_Functions::DVD.new
			#yes I know this line is ugly, I need to work on a cleaner way of doing this
			#but the splat operator is oh so fun!
			cur_dvd.title, cur_dvd.studio, cur_dvd.released, cur_dvd.status, cur_dvd.sound,
				cur_dvd.versions, cur_dvd.price, cur_dvd.rating, cur_dvd.year, 
				cur_dvd.genre, cur_dvd.aspect, cur_dvd.upc, cur_dvd.dvd_release = *curr_row
			cur_dvd.save
		end
		puts "Parsing complete"
	end

end

