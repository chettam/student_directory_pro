
#Module managing the menues and sub menues
module Menu
   require './prompt.rb'
   require './student.rb'
   require './list_student.rb'
   require './directory.rb'
# menu for the student directory
def self.interactive_menu # can be split into two methods
  loop do
    print_menu
    process(Prompt.simple_prompt)
  end
end

# sub menu for listing  users
def self.interactive_sub_menu
  loop do
    print_sub_menu
    process_sub_menu(Prompt.simple_prompt)
  end
end


# print menu choice
def self.print_menu
  Prompt.print_separator
  puts "Welcome to Makers Academy directory"
  Prompt.print_separator
  puts "\t 1 - Add a new student"
  puts "\t 2 - Modify an existing student"
  puts "\t 3 - Delete an existing student"
  puts "\t 4 - List all the students (with filtering)"
  puts "\t 5 - Add field to the directory"
  puts "\t 6 - Remove field from the directory"
  puts "\t 7 - list the current fields"
  puts "\t E - Exit"
  Prompt.print_separator
end

#print sub menu choice
def self.print_sub_menu
  Prompt.print_separator
  puts "choose your list :"
  Prompt.print_separator
  puts "\t 1 - List all the students"
  puts "\t 2 - List student by specific cohort"
  puts "\t 3 - Search Student by field"  
  puts "\t 4 - List student's filtered by firstnames length"
  puts "\t R - Return to main menu"
  Prompt.print_separator
end

# handle choice selection
def self.process(selection)
  student = Student.new
  case selection
  when "1"
    student.input_student   
  when "2"
    student.modify_student
  when "3"
    student.delete_student
  when "4"
    interactive_sub_menu
  when "5"
    Field.add_directory_field
  when "6"
    Field.delete_directory_field
  when "7"
    Field.list_directory_field
  when "E" 
    exit
  else
    puts "Not sure I understand, please try again !"
  end
end

#handle choice in sub menu
def self.process_sub_menu(selection)
  list_student=ListStudent.new
  case selection
  when "1"
    list_student.list_student
  when "2"
    list_student.list_student_cohort
  when "3"
    list_student.search_student
  when "4"
    list_student.list_student_name_length
  when /r/i
    interactive_menu
  else
    puts "Not sure I understand, please try again !"
  end
end
end