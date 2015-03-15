require 'net/http'
require "htmlentities"
require "uri"
class SearchController < ApplicationController
	@@parser = nil
 	def get_filename
		begin

			@@parser['files'].each do |key, value|
				@title = key
				end
		rescue
				@error = "An error occured due to JSON format"
		end
	end

	def get_owner_infos
		begin
			@user_login = @@parser['owner']['login']
			@user_avatar = @@parser['owner']['avatar_url']
		rescue
			@error = "An error occured due to JSON format"
		end
	end

	def index

		begin
			@url = "https://api.github.com/gists/"+params[:q]
			@data = open(@url).read
			@@parser = JSON.parse(@data)
			get_filename
			get_owner_infos
			@content = @@parser['files'][@title]['content']
			@error = nil
		rescue OpenURI::HTTPError => ex
			@error = "Gist \""+ params[:q] + "\" not found"
		end
	end

	def save
		begin
				gist = Gist.new(:title => params[:title],
											:description => @@parser['files'][params[:title]]['content'],
											:url => params[:user_avatar],
											:username => params[:user_login])

				@description = @@parser['files'][params[:title]]['content']
			gist.save
		rescue
			@error = "An error occured"
		end
	end
end