MONTHS = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    if students.count != 1
      str = "students"
    else
      str = "student"
    end
    puts "Now we have #{students.count} #{str}"
    # get another name from the user
    name = gets.strip
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students_by_cohort)
    students_by_cohort.map { |key, value| puts "Cohort: #{key}, students: #{value.join(", ")}"}
end

def sort_by_cohort(students)
  cohort_sort = {}
  students.each do |student|
    co = student[:cohort]
    stu = student[:name]
    if cohort_sort[co] == nil
      cohort_sort[co] = [stu]
    else
      cohort_sort[co].push(stu)
    end
  end
  return cohort_sort
end

def print_footer(students)
    puts "Overall, we have #{students.count} great students
end

students = input_students
#nothing happens until we call the methods
if students == []
  return nil
else
  print_header
  print(sort_by_cohort(students))
  print_footer(students)
end
