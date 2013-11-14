module Prompt
	# print a nice(r) prompt and ask user input
	def self.simple_prompt
	  print "> \t"
	  gets.chomp
	end

	# receive a message to display and ask user input
	def self.full_prompt(message)
	  print_separator
	  puts message
	  simple_prompt
	end
	# print separator
	def self.print_separator
	  puts "\n-----------------------------------------\n"
	end

end

