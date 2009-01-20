require 'rubygems'
require 'net/http'
require 'zip/zipfilesystem'

@address = ARGV[0]
#default value unless alternate is specified on the command line
@address ||= 'http://www.hometheaterinfo.com/download/dvd_csv.zip'

def download_file
	#split file path on / characters and check to see if http:// was entered
	url_array = @address.split('/')
	if url_array[0].eql? "http:" 
  	domain = url_array[2]
  	start_count = 3
	else 
  	domain = url_array[0]
  	start_count = 1
	end
 
	#now that we have the domain, rebuild the path to the file
	path = ""
	start_count.upto(url_array.length() -1) do |x|
  	path << '/'
  	path << url_array[x]
	end
	puts "Downloading the file..."
	Net::HTTP.start(domain) do |http|
  	resp = http.get(path)
  	open(@address.split("/").last, "wb") do |file|
  	  file.write(resp.body)
  	end
	end
	puts "Download complete"
end

def unzip(source_file, target_dir)
	Dir.mkdir target_dir if not File.exists? target_dir
	
	Zip::ZipFile.open(source_file) do |zip|
		curr_dir = zip.dir

		curr_dir.entries('.').each do |file|
			zip.extract(file, "#{target_dir}/#{file}")
		end
	end
	rescue Zip::ZipDestinationFileExistsError => ex
end

def cleanup
	FileUtils.rm(@address.split("/").last)
end

download_file
unzip(@address.split("/").last, "../dvd")
cleanup
