# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Employee.create(name: 'Hemanshu', email: 'hemanshu@rainbow.com', password: 'hemanshu', contact: '7904727567', employee_type: 'admin')
Employee.create(name: 'Nancy', email: 'nancy@rainbow.com', password: 'nancy', contact: '', employee_type: 'manager')
Employee.create(name: 'Mahesh', email: 'mahesh@rainbow.com', password: 'mahesh', contact: '', employee_type: 'designer')
Employee.create(name: 'Shankar', email: 'shankar@rainbow.com', password: 'Shankar', contact: '', employee_type: 'designer')
Employee.create(name: 'Piyush', email: 'piyush@rainbow.com', password: 'Piyush', contact: '', employee_type: 'admin')
Employee.create(name: 'Ravi', email: 'ravi@rainbow.com', password: 'Ravi', contact: '', employee_type: 'finisher')