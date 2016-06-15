namespace :scrapper do
  desc "analyzise the websites and store the values in database"
  require 'nokogiri'
	require 'open-uri'
	require 'apriori'
  task search: :environment do
	  # puts File.dirname(__FILE__)
	  common_words = []
	  e=[]
	  k=[]
	  File.open("#{File.dirname(__FILE__)}/english.txt", "r") do |f|
	  	f.each_line do |line|
	  		common_words = common_words + [line.strip]
	  	end
	  end
	  Url.destroy_all
	  Search.destroy_all
	  common_words = common_words.to_set
  	File.open("#{File.dirname(__FILE__)}/url.txt", "r") do |f|
  		f.each_line do |line|
  			
    		doc = Nokogiri::HTML(open(line))
    		meta_desc = doc.css("meta[name='description']").first 
				description = meta_desc['content']
				title = doc.css('title').text
				url = Url.create(url: line, description: description, title: title)
				meta_desc = doc.css("meta[name='keywords']").first 
				keywords = meta_desc['content']  
				keywords = keywords.split
				# keywords.split.each do |i|
				# 	Search.create(url: line, keyword: i, count: 10)
				# end
				doc.css('script, link').each { |node| node.remove }
				# puts doc.css('body').text.squeeze(" \n").gsub(/<\/?[^>]*>/, '').gsub(/\n\n+/, "\n").gsub(/^\n|\n$/, '')
				doc.search('//text()').each do |t|
  				if !t.content.strip.blank?
  					b=t.content.strip.split.to_set
  					c = b & common_words
  					d = b - c
  					e = e + [d.to_a]
  					k =  k + d.to_a 
  					k = k.to_set.to_a
  				end
				end
				minimum_support = 5
				k.each do |i|
					z=0
					e.each do |j|
						if j.include?(i)
							z=z+1
						end
					end

					if (z.to_f/e.count)*100 > 5
						if !keywords.include?(i)
							Search.create(url: url, keyword: i, count: z)
						else
							keywords - [i]
							Search.create(url: url, keyword: i, count: z)
						end
					end
				end
  		end
		end
  end
end
