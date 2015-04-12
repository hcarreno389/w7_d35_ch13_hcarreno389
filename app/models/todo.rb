class Todo < ActiveRecord::Base
	def initialize
		@title = []
		@author = []
		@date = []
		@link = []
		@all = []
		notice = HTTParty.get('http://www.reddit.com/.json')
		notice['data']['children'].each do |feed|
			title = feed['data']['title']
			@title.push(title)
			@all.push(title)
			author = feed['data']['author']
			@author.push(author)
			@all.push(author)
			date = Time.at(feed['data']['created_utc'])
			@date.push(date)
			@all.push(date)
			link2 = feed['data']['permalink']
			link1 = feed['data']['domain']
			link = link1 + link2
			@link.push(link)
			@all.push(link)
		end

		notice = HTTParty.get('http://digg.com/api/news/popular.json')
		notice['data']['feed'].each do |feed|
			title = feed['content']['title_alt']
			@title.push(title)
			@all.push(title)
			author = feed['content']['author']
			@author.push(author)
			@all.push(author)
			date = Time.at(feed['date_published'])
			@date.push(date)
			@all.push(date)
			link = feed['content']['url']
			@link.push(link)
			@all.push(link)
		end

		notice = HTTParty.get('http://mashable.com/stories.json/')
		notice["hot"].each do |feed|
			title = feed['title']
			@title.push(title)
			@all.push(title)
			author = feed['author'] 
			@author.push(author)
			@all.push(author) 
			date = feed['post_date']
			@date.push(date)
			@all.push(date)
			link = feed['link'] 
			@link.push(link)
			@all.push(link)
		end
	end

	def all
		@all
	end

	def titles
		@title
	end

	def authors
		@author
	end

	def dates
		@date
	end

	def links
		@link
	end
end
