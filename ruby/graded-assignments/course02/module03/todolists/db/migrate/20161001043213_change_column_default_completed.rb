class ChangeColumnDefaultCompleted < ActiveRecord::Migration
  def change
  	change_column_default :todo_items, :completed, false
  end
end
