require 'FileUtils'

class FileFetcher

	def initialize(url)
		if File.exists?(url)
			@url = url
		else
			raise "There is not a file at the URL you specified"
		end
	end

	attr_accessor :url

end

test = FileFetcher.new "http://www.hometheaterinfo.com/download/dvd_csv.zip"
