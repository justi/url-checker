require_relative 'dsl'

# For tests, run:
# ruby run.rb example.txt
filename = ARGV[0]

if filename
	data = File.read(filename)
	Dsl.new("getbadges") do
		eval(data)
	end.display_results.send_email
else
	puts "Please type: ruby run.rb input_txt_file"
end