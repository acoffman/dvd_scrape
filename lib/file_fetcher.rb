require 'rubygems'
require 'net/http'
require 'zip/zipfilesystem'

class FileFetcher
	
	def initialize(address,target_dir)
		@address = address
		@file_name = @address.split('/').last
		@target_dir = target_dir

		#split file path on / characters and check to see if http:// was entered
		url_array = @address.split('/')
		if url_array[0].eql? "http:" 
  		@domain = url_array[2]
  		start_count = 3
		else 
  		@domain = url_array[0]
  		start_count = 1
		end
 
		#now that we have the domain, rebuild the path to the file
		@path = ""
		start_count.upto(url_array.length() -1) do |x|
  		@path << '/'
  		@path << url_array[x]
		end
	end


	def download
		puts "Downloading #{@file_name}"
		#begin downloading the file
		Net::HTTP.start(@domain) do |http|
  		response = http.get(@path)
  		open(@file_name, "wb") do |file|
  	  	file.write(response.body)
  		end
		end
		puts "Download complete."
	end


	def unzip
		puts "Unzipping #{@file_name}."
		Dir.mkdir @target_dir if not File.exists? @target_dir
	
		Zip::ZipFile.open(@file_name) do |zip|
			curr_dir = zip.dir

			curr_dir.entries('.').each do |file|
				zip.extract(file, "#{@target_dir}/#{file}")
			end
		end
		rescue Zip::ZipDestinationFileExistsError => ex
		puts "Unzipping complete."
	end


	def cleanup
		puts "Cleaning up."
		FileUtils.rm(@file_name)
		puts "Cleanup complete."
	end

	attr_accessor :file_name, :address

end
