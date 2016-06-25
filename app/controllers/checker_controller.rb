class CheckerController < ApplicationController
	require 'nokogiri'
	require 'open-uri'
  def index
  	@id = params[:id]
  	@url = Url.find(@id)
  	doc = Nokogiri::HTML(open(@url.url.strip))
  	meta_desc = doc.css("meta[name='keywords']").first 
		@keywords = meta_desc['content'] if meta_desc
  	@search = @url.searchs
  end
end
