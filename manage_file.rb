# module for methods related to file operation
module ManageFile
	require 'json'
	# open a Json formatted file and parse it 
	def self.load_json(filename,options={})
	  File.open(filename, "r") do |f|
	    return JSON.parse(f.read ,options) || []
	  end
	end
	# save a json formmated file from an array
	def self.save_json(filename,array_to_save)
		File.open( filename, "w") do |f|
	    f.write(array_to_save.to_json)   
	  end 
	end
end