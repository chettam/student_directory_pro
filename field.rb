# Module to manage field related methods

module Field
	require './prompt.rb'
		#load directory field from json formatted file
		@directory_fields   = []

	def self.load_directory_fields
	  @directory_fields = ManageFile.load_json("/tmp/directory_field")
	  puts "Field Loaded"
	end

	#save directory to a json formatted file
	def self.save_directory_field
	  ManageFile.save_json("/tmp/directory_field",@directory_fields)
	  puts "Fields saved"
	end

	# add field to the directory
	def self.add_directory_field
	  field = Prompt.full_prompt("what field woud you like to add ?")
	  @directory_fields << field # make it plural
	  puts "Field Added !"
	  save_directory_field
	end

	# remove field
	def self.delete_directory_field
	  field = Prompt.full_prompt("what field woud you like to remove?")
		unless field == "first_name" || field == "last_name" || field =="cohort"
		  @directory_fields.delete_if{|current_field| current_field == field} 
			puts "Field Removed !"
		  save_directory_field
		else
			puts "Mandatory fields can't be deleted"
		end
	end

	# list directory field
	def self.list_directory_field
	  @directory_fields.each {|field| puts field} # puts @directory_fields
	end

	#return an array of directory fields
	def self.get_directory_field
		return @directory_fields
	end


end