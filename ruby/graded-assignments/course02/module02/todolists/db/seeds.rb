# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TodoItem.destroy_all
TodoList.destroy_all
Profile.destroy_all
User.destroy_all

User.create! [
  {username: "Fiorina", password_digest: "abc123"},
  {username: "Trump", password_digest: "abc123"},
  {username: "Carson", password_digest: "abc123"},
  {username: "Clinton", password_digest: "abc123"}
]

User.find_by!(username: "Fiorina").create_profile!(gender: "female", birth_year: 1954, first_name: "Carly", last_name: "Fiorina")
User.find_by!(username: "Trump").create_profile!(gender: "male", birth_year: 1946, first_name: "Donald", last_name: "Trump")
User.find_by!(username: "Carson").create_profile!(gender: "male", birth_year: 1951, first_name: "Ben", last_name: "Carson")
User.find_by!(username: "Clinton").create_profile!(gender: "female", birth_year: 1947, first_name: "Hillary", last_name: "Clinton")

User.find_by!(username: "Fiorina").todo_lists.create!(list_name: "cf_list", list_due_date: (Date.today + 1.year))
User.find_by!(username: "Trump").todo_lists.create!(list_name: "dt_list", list_due_date: (Date.today + 1.year))
User.find_by!(username: "Carson").todo_lists.create!(list_name: "bc_list", list_due_date: (Date.today + 1.year))
User.find_by!(username: "Clinton").todo_lists.create!(list_name: "hc_list", list_due_date: (Date.today + 1.year))

TodoList.find_by!(list_name: "cf_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 01", description: "todo item 01", completed: false)
TodoList.find_by!(list_name: "cf_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 02", description: "todo item 02", completed: false)
TodoList.find_by!(list_name: "cf_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 03", description: "todo item 03", completed: false)
TodoList.find_by!(list_name: "cf_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 04", description: "todo item 04", completed: false)
TodoList.find_by!(list_name: "cf_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 05", description: "todo item 05", completed: false)

TodoList.find_by!(list_name: "dt_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 11", description: "todo item 11", completed: false)
TodoList.find_by!(list_name: "dt_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 12", description: "todo item 12", completed: false)
TodoList.find_by!(list_name: "dt_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 13", description: "todo item 13", completed: false)
TodoList.find_by!(list_name: "dt_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 14", description: "todo item 14", completed: false)
TodoList.find_by!(list_name: "dt_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 15", description: "todo item 15", completed: false)

TodoList.find_by!(list_name: "bc_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 21", description: "todo item 21", completed: false)
TodoList.find_by!(list_name: "bc_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 22", description: "todo item 22", completed: false)
TodoList.find_by!(list_name: "bc_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 23", description: "todo item 23", completed: false)
TodoList.find_by!(list_name: "bc_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 24", description: "todo item 24", completed: false)
TodoList.find_by!(list_name: "bc_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 25", description: "todo item 25", completed: false)

TodoList.find_by!(list_name: "hc_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 31", description: "todo item 31", completed: false)
TodoList.find_by!(list_name: "hc_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 32", description: "todo item 32", completed: false)
TodoList.find_by!(list_name: "hc_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 33", description: "todo item 33", completed: false)
TodoList.find_by!(list_name: "hc_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 34", description: "todo item 34", completed: false)
TodoList.find_by!(list_name: "hc_list").todo_items.create(due_date: (Date.today + 1.year), title: "Todo 35", description: "todo item 35", completed: false)
