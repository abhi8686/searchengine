class HomeController < ApplicationController
	def index
	
	end

	def search

		query = params[:query].split

		if !(query.count > 1)
			@search_data = Search.find_by(keyword: params[:query]).to_a
			@query = params[:query]
			if @search_data.blank? 
				flash[:notice] = "No results found please try again with different keywords"
			end
		else
			flash[:notice] = 'This search has been developed to search words only' 
		end
	end

	private

	def analyize_data(query)
	end
end
