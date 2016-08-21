require_relative 'dsl.rb'

filename = ARGV[0]
data = File.read(filename) if filename
ABC.new("getbadges") do
	eval(data)
	#get 'https://getbadges.io/image.svg', :have_mime_type => 'image/svg'
	#post 'https://getbadges.io', :body => {content: 3}, :respond_with => 200
end.display_results()