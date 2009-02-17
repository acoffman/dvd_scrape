require 'rubygems'
require 'amazon/aws/search'
require 'hpricot'
require 'open-uri'
require 'file_fetcher.rb'
require 'db_module.rb'

include Amazon::AWS
include Amazon::AWS::Search

DB_Functions.connect

class Cover_Fetcher


	def initialize
		@target_dir = "../imgs/"
		@ACCESS_KEY = "1WHJD5HZTZ50T57KKZR2"
	end

	def fetch_all
		dvds = DB_Functions::DVD.find(:all, :conditions => "has_art = false")

		response_group = ResponseGroup.new('Small')
		request = Request.new(@ACCESS_KEY)
		request.locale =  'us'
		
		puts "Fetching Covers"
		dvds.each do |curr_dvd|
			begin
				lookup = ItemLookup.new('UPC', {'ItemId' => curr_dvd.upc, 'SearchIndex' => 'DVD'} )
				response = request.search(lookup, response_group)
				info_page = Hpricot(open(response.item_lookup_response.items.item.detail_page_url))
				cover_url = info_page.search("//img[@id='prodImage']").first[:src]

				if not cover_url.include?("no-image")
					dl = FileFetcher.new(cover_url, @target_dir)
					dl.download("#{curr_dvd.upc}.jpg")
					curr_dvd.has_art = true
				end
			rescue
				curr_dvd.has_art = false
			end
		end
	end
end
