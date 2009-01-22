require 'rubygems'
require 'db_module.rb'

begin
	require 'fastercsv'
	$fastercsv = true
rescue LoadError
	require 'csv'
end


#connect to the SQL database
DB_Functions.connect

class Parser

	def initialize(filename)
		@filename = filename
	end

	def parse
		
		if not $fastercsv
			puts "Parsing #{@filename.split("/").last} using the standard CSV library."
			CSV::Reader.parse(File.open(@filename,'rb')) do |curr_row|
				save_row(curr_row)
			end

		else
			puts "Parsing #{@filename.split("/").last} using the FasterCSV library."			
			FasterCSV.foreach(@filename) do |curr_row|
				save_row(curr_row)
			end
		end

		puts "Parsing complete"
	end
	
	def save_row(row)
		cur_dvd = DB_Functions::DVD.new
		#yes I know this line is ugly, I need to work on a cleaner way of doing this
		#but the splat operator is oh so fun!
		cur_dvd.title, cur_dvd.studio, cur_dvd.released, cur_dvd.status, cur_dvd.sound,
			cur_dvd.versions, cur_dvd.price, cur_dvd.rating, cur_dvd.year, 
			cur_dvd.genre, cur_dvd.aspect, cur_dvd.upc, cur_dvd.dvd_release = *row		
		cur_dvd.save
	end

end

