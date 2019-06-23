@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to file, by default students.csv"
  puts "4. Load the list from file, by default students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "9"
    puts "Exiting program"
    exit # this will cause the program to terminate
  when "3"
    save_students
  when "4"
    load_students(file_name())
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  name = prompt()
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    add(name, "november")
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def prompt
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  return name
end

def show_students
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def file_name
  puts "Enter a file:"
  file_chosen = gets.chomp
  # open the file for writing
  if file_chosen == ""
    file_chosen = "students.csv"
  end
  return file_chosen
end

def save_students
  puts "Enter a file:"
  file_chosen = file_name()
  file = File.open(file_chosen, "w")
  # iterate over the array of students
  write(file)
  file.close
  file_chosen
  puts "Saved the students to #{file_chosen}"
end

def write(file)
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    file.puts(student_data.join(","))
  end
end

def load_students(filename)
  File.open(filename, "r") do |f|
    f.readlines.each do |line|
      add(line.chomp.split(','))
    end
  end
end

def try_load_students
  filename = ARGV.first# first argument from the command line
  return if filename.nil?
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def add(name, cohort="november")
  @students << {name: name, cohort: cohort.to_sym}
end

try_load_students
interactive_menu
