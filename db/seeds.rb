# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Employee.create(name: 'Hemashu', email: 'hemanshu@rainbow.com', password: 'hemanshu', contact: '7904727567', employee_type: 'admin')
Employee.create(name: 'Nancy', email: 'nancy@rainbow.com', password: 'nancy', contact: '', employee_type: 'manager')
Employee.create(name: 'Mahesh', email: 'mahesh@rainbow.com', password: 'mahesh', contact: '', employee_type: 'designer')

Customer.create(name: 'Piyush', email: '', mobile: '9894503030')
Customer.create(name: 'Rupal', email: '', mobile: '9344066696')

Lead.create(customer_id: Customer.last.id, item_type: 0, quantity: 200, paper_type: 'Random GSM', size: 'random size', s_no: 'erdctvfgbyh', payment_details: 'xrdcfvghbnj', slip_no: 'rdfgh', price: 400.00)
Lead.create(customer_id: Customer.last.id, item_type: 1, quantity: 300, paper_type: 'Random GSM', size: 'random size', s_no: 'erdctvfgbyh', payment_details: 'xrdcfvghbnj', slip_no: 'rdfgh', price: 400.00)