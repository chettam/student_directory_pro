 require './directory.rb'
 require './field.rb'
 require './menu.rb'



def start
  Directory.load_directory
  Field.load_directory_fields
  Menu.interactive_menu
end


start