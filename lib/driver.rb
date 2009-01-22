require 'file_fetcher.rb'
require 'parse_csv.rb'

#All arguments are optional, and default values will be assigned if need be.
#First argument: The URL of the zip file
#Second Argument: The target folder for unzipping
#Third argument, the name of the file to be parsed

address = ARGV[0]
target = ARGV[1]

address ||= 'http://www.hometheaterinfo.com/download/dvd_csv.zip'
target  ||= '../dvd/'

filename = target + ARGV[2] if not ARGV[2] == nil
	
filename ||= target + "dvd_csv.txt"

fetcher = FileFetcher.new(address, target)

fetcher.download
fetcher.unzip
fetcher.cleanup

parser = Parser.new(filename)

parser.parse

