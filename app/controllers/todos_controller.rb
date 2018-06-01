class TodosController < ApplicationController
  def index
    @todos = Todo.all
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      redirect_to @todo
    else
      render 'new'
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    redirect_to todos_path
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def show
    @todo = Todo.find(params[:id])
     @articles = @todo.articles
  end

  def update
    @todo  = Todo.find(params[:id])

    if @todo.update(todo_params)
      redirect_to @todo
    else
      render 'edit'
    end
  end

  def complete
    @todo = Todo.where(id: params[:todo_id]).first
    params[:articles_checkbox].each do |check|
      article_id = check
      @article = Article.find_by_id(article_id)
      @article.update_attribute(:is_done, true)
#      flash[:notice] = "Task completed"
    end
    redirect_to todo_path(@todo)
  end
  private
  def todo_params
    params.require(:todo).permit(:title)
  end
end
