class ArticlesController < ApplicationController
  def new
    article=Article.new
  end

  def create
    @todo = Todo.where(id: params[:todo_id]).first
    @article = @todo.articles.build(article_params)

    if @article.save
      redirect_to todo_path(@todo)
    else
      render 'new'
    end
  end

  def show
    @todo = Todo.where(id: params[:todo_id]).first
    @article = @todo.articles.find(params[:id])
  end

  def edit
    @todo = Todo.where(id: params[:todo_id]).first
    @article = @todo.articles.find(params[:id])
  end

  def update
    @todo = Todo.where(id: params[:todo_id]).first
    @article = @todo.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to todo_path(@todo)
    else
      render 'edit'
    end
  end

  def destroy
    @todo = Todo.where(id: params[:todo_id]).first
    @article = @todo.articles.find(params[:id])
    @article.destroy

    redirect_to todo_path(@todo)
  end

  def complete
    @todo = Todo.where(id: params[:todo_id]).first
    params[:articles_checkbox].each do |check|
      article_id = check
      @article = Article.find_by_id(article_id)
      @article.update_attribute(:is_done, true)
      flash[:notice] = "Task completed"
    end
    redirect_to todo_path(@todo)
  end

  private
  def article_params
    params.require(:article).permit(:title)
  end
end
