$datas = []
class ABC
    attr_accessor :id, :urls
    
    def initialize(id, &block)
      self.id = id
	  self.urls = []
	  instance_eval &block
	end
	
	def url(url, options = {})
	  url = {:url => url}
	  options.each do |option|
	  	url[option.first] = option.last
	  end
	  urls << url
	end
	
	def add(datas)
		datas << self
	end
end

ABC.new("getbadges") do 
	url 'http://getbadges.io', :respond => :permanent_redirect, :respond_to => 'https://getbadges.io'
	url 'https://https://getbadges.io/image.svg', :have_mime_type => 'image/svg'
	url 'https://getbadges.io', :body => {content: 3}, :respond_with => :ok
end.add($datas)
