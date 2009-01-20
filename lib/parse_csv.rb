require 'csv'
require 'activerecord'

#connect to the database we are using
ActiveRecord::Base.establish_connection (
	:adapter => 'mysql'
	:username => 'root'
	:database => 'dvd_parse'
)

class DVD < ActiveRecord::Base
end

def parse(filename)
	CSV::Reader.parse(File.open(filename,'rb')) do |curr_row|
		cur_dvd = DVD.new
		
		DVD.save
	end
end

