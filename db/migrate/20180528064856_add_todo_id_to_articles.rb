class AddTodoIdToArticles < ActiveRecord::Migration[5.2]
  def change
    add_index :articles, :todo_id
  end
end
