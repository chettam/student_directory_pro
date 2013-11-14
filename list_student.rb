class ListStudent

	def initialize()
		@directory_students =Directory.get_students
	end
	# list student
	def list_student
		Directory.print_inside_separators do
	  	puts " Following is the list of all the students"
	    raw_list_student(@directory_students)
	  end
	end

	# list student by cohort
	def list_student_cohort
	  cohort = Prompt.full_prompt("Please enter a student cohort name")
	  Prompt.print_separator
	  puts "Following is the list of the students of the #{cohort} cohort"
	 	raw_list_student(@directory_students.select{|student| student[:cohort] == cohort })
	end

	# search student 
	def search_student
	  Directory.print_inside_separators do
	  puts "please enter one of the following field :"
	  Field.list_directory_field
	  end
	  field = Prompt.simple_prompt
	  Prompt.print_separator
	  # ask for search expression
	  search_expression=Prompt.full_prompt("puts regex search expression ?")
	  raw_list_student(@directory_students.select{|student| student[field.to_sym] =~ /#{search_expression}/})
	end

	# filter student by the lenght of their first name
	def list_student_name_length
	  length = Prompt.full_prompt("What length of first name do you want ?")
	  puts @directory_students.select{|student| student[:first_name].length == length.to_i }
	end

	# return  just a student list ( no formating)
	def raw_list_student(list)
		Directory.print_inside_separators do
		list.each_with_index { |name,i| puts "#{i+1} : #{name.inspect}"}
		end
	end
end