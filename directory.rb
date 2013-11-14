# break into several files?

 # to use Json file format
 require './manage_file.rb'
 require './menu.rb'
# our in memory directory
@directory_students = []
@directory_fields   = []

# print separator
def print_separator
  puts "\n-----------------------------------------\n"
end

# print a nice(r) prompt and ask user input
def prompt
  print "> \t"
  gets.chomp
end


#load directory from json formatted file
def load_directory
  @directory_students= ManageFile.load_json("/tmp/directory",:symbolize_names => true)
  puts "Directory Loaded"
end

#save directory to a json formatted file
def save_directory
  ManageFile.save_json("/tmp/directory",@directory_students)
  puts "Directory saved"
end

#load directory field from json formatted file
def load_directory_fields
  @directory_fields = ManageFile.load_json("/tmp/directory_field")
  puts "Field Loaded"
end

#save directory to a json formatted file
def save_directory_field
  ManageFile.save_json("/tmp/directory_field",@directory_fields)
  puts "Fields saved"
end

#add a student
def input_student # does several things as well, try splitting
  print_separator
  student = Hash.new # just use {}
  @directory_fields.each do |field|
    puts "Please fill the following field: #{field}"
    student[field.to_sym] = prompt
  end
  name = [student[:first_name], student[:last_name]].join(' ') # implies that they exist
  unless student_exist?(name) 
    @directory_students<< student
    save_directory
  else
    puts "This student already exist"
  end
end

#remove a student
def delete_student
  name = full_prompt("Please enter the full name of your student (Firstname, Lastname) :")
  if student_exist?(name)
    student_delete(name)
    save_directory
  else
    puts "This stuendent cannot be found"
  end
end

#modify a student
def modify_student # probably can be split into 2-3 methods
  name = full_prompt("Please enter the full name of your student (Firstname, Lastname) :") # repetition of 162
  if student_exist?(name)
    # load current student
    # this looks like a method
    current_student = @directory_students.find {|student| student[:first_name] == name.split(' ')[0] and student[:last_name] == name.split(' ')[1]}
    print current_student
    @directory_fields.each do |field|
      puts "Please fill the following field: #{field}. current value #{current_student[field.to_sym]}"
      current_student[field.to_sym] = prompt
    end
    student_delete(name)
    @directory_students<< current_student
    save_directory
  end
end

def print_inside_separators
  print_separator
  yield
  print_separator
end

# list student
def list_student
  print_inside_separators do
    puts " Following is the list of all the students"
    @directory_students.each_with_index { |name,i| puts "#{i+1} : #{name.inspect}"}
  end
end

# list student by cohort
def list_student_cohort
  cohort = full_prompt("Please enter a student cohort name")
  list = @directory_students.select{|student| student[:cohort] == cohort }
  print_separator
  puts "Following is the list of the students of the #{cohort} cohort"
  list.each_with_index { |name,i| puts "#{i+1} : #{name.inspect}"}
end

# search student 
def search_student # fairly long
  print_separator
  # ask for field
  puts "please enter one of the following field :"
  @directory_fields.each{|field| puts field.to_s }
  print_separator
  field = prompt
  print_separator
  # ask for search expression
  puts "regex search expression ?"
  search_expression=prompt
  list =@directory_students.select{|student| student[field.to_sym] =~ /#{search_expression}/}
  list.each_with_index { |name,i| puts "#{i+1} : #{name.inspect}"} # the same as 209
end

# filter student by the lenght of their first name
def list_student_name_length
  length = full_prompt("What length of first name do you want ?")
  print @directory_students.select{|student| student[:first_name].length == length.to_i }
end

# add field to the directory
def add_directory_field
  field = full_prompt("what field woud you like to add ?")
  @directory_fields << field # make it plural
  puts "Field Added !"
  save_directory_field
end

def full_prompt(message)
  print_separator
  puts message
  prompt
end

# remove field
def delete_directory_field
  field = full_prompt("what field woud you like to remove?")
  @directory_fields.delete_if{|current_field| current_field == field} 
  puts "Field Removed !"
  save_directory_field
end 

# list directory field
def list_directory_field
  @directory_fields.each {|field| puts field} # puts @directory_fields
end

def search_by_first_last_names_block(first, last)

end

#check if student exist
def student_exist?(name)
  first, last =name.split(' ')
  @directory_students.any? {|student| student[:first_name] == first && student[:last_name] == last}
end

# delete student
def student_delete(name)
  match_name =name.split(' ')
  @directory_students.delete_if {|student| student[:first_name] == match_name[0] && student[:last_name] == match_name[1]}
end

def start
  load_directory
  load_directory_fields
  Menu.interactive_menu
end

start
