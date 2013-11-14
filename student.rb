# Module to keep student related methods
class Student

 require './prompt.rb'
 require './directory.rb'
	#add a student

	def initialize()
		@directory_fields = Field.get_directory_field
		@directory_students =Directory.get_students
	end


	def input_student # does several things as well, try splitting
	  Prompt.print_separator
	  student = {}
	  directory_fields =Field.get_directory_field
	  directory_fields.each do |field|
	    puts "Please fill the following field: #{field}"
	    student[field.to_sym] = Prompt.simple_prompt
	  end
	  name = [student[:first_name], student[:last_name]].join(' ') # implies that they exist
	  unless student_exist?(name) 
	   		Directory.set_directory(student)
	  else
	    puts "This student already exist"
	  end
	end

	#remove a student
	def delete_student
	  name = Prompt.full_prompt("Please enter the full name of your student  you wish to delete (Firstname, Lastname) :")
	  if student_exist?(name)
	    student_delete(name)
	    Directory.save_directory
	  else
	    puts "This stuendent cannot be found"
	  end
	end

	#modify a student
	def modify_student 
	  name = Prompt.full_prompt("Please enter the full name of your student you wish to modify  (Firstname, Lastname) :")
	  if student_exist?(name)
	    # load current student
	    current_student = student_find(name)
	    directory_fields= Field.get_directory_field
	    directory_fields.each do |field|
	      puts "Please fill the following field: #{field}. current value #{current_student[field.to_sym]}"
	      current_student[field.to_sym] = Prompt.simple_prompt
	    end
	    student_delete(name)
	    Directory.set_directory(current_student)   
	  end
	end

	def students_equal(student,name)
		first, last =name.split(' ')
		student[:first_name] == first && student[:last_name] == last
	end

	# find a student by name
	def student_find(name)
	@directory_students.find {|student|students_equal(student,name)}
	end

	#check if student exist
	def student_exist?(name)	  
	  @directory_students.any? {|student| students_equal(student,name)}
	end

	# delete student
	def student_delete(name)
	  @directory_students.delete_if {|student| students_equal(student,name)}
	end
end