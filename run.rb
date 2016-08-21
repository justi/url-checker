require_relative 'dsl'

# For tests, run:
# ruby run.rb example.txt
filename = ARGV[0]

if filename
	data = File.read(filename)
	ABC.new("getbadges") do
		eval(data)
		#get 'https://getbadges.io/image.svg', :have_mime_type => 'image/svg'
		#post 'https://getbadges.io', :body => {content: 3}, :respond_with => 200
	end.display_results()
else
	puts "Please type: ruby run.rb input_txt_file"
end