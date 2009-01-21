require 'file_fetcher.rb'
require 'parse_csv.rb'

address = ARGV[0]
target = ARGV[1]

address ||= 'http://www.hometheaterinfo.com/download/dvd_csv.zip'
target  ||= '../dvd/'

if not ARGV[2] == nil
	filename = target + ARGV[2]

filename ||= target + "dvd_csv.txt"

fetcher = FileFetcher.new(address, target)

fetcher.download
fetcher.unzip
fetcher.cleanup

parser = Parser.new(filename)

parser.parse
