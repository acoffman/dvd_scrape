#This code all appeared at more than one location in my previous
#implementation, so I pulled it out into a module to DRY it up a bit.
require 'activerecord'
module DB_Functions

	def self.connect
		#connect to the mysql database we're going to use
		ActiveRecord::Base.establish_connection(
		:adapter => 'mysql',
		:username => 'root',
		:database => 'dvd_parse'
		)
	end

	#class to represent a DVD entry in the database table
	class DVD < ActiveRecord::Base
	end

end
