module Directory

   # to use Json file format
   require './manage_file.rb'
   require './prompt.rb'
   require './field.rb'
  # our in memory directory
  @directory_students = []
  


  #load directory from json formatted file
  def self.load_directory
    @directory_students= ManageFile.load_json("/tmp/directory",:symbolize_names => true)
    puts "Directory Loaded"
  end

  #save directory to a json formatted file
  def self.save_directory
    ManageFile.save_json("/tmp/directory",@directory_students)
    puts "Directory saved"
  end

  def self.print_inside_separators
    Prompt.print_separator
    yield
    Prompt.print_separator
  end
  # send the directory as an array
  def self.get_students
    return @directory_students
  end

  def self.set_directory(student)
    @directory_students<< student
    save_directory
  end



end

