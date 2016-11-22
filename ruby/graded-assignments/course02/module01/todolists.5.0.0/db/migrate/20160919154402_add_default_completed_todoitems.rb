class AddDefaultCompletedTodoitems < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :todo_items, :completed, false
  end
end
