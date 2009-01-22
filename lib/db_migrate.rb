#This is only required to set up the initial dvds table in the 
#dvd_parse database, it should only need to be run once

require 'rubygems'
require 'db_module.rb'

DB_Functions.connect

#initial migration to create our table
class CreateDVDsTable < ActiveRecord::Migration

	def self.up
		create_table :dvds do |t|
			t.string :title
			t.string :studio
			t.string :released
			t.string :status
			t.string :sound
			t.string :versions
			t.string :price
			t.string :rating
			t.string :year
			t.string :genre
			t.string :aspect
			t.string :upc
			t.string :dvd_release
		end
	end

	def self.down
		drop_table :dvds
	end

end

#CreateDVDsTable.migrate(:up)