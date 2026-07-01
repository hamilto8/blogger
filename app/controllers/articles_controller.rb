class ArticlesController < ApplicationController
  include ArticlesHelper

  def index
    @articles = Article.order(created_at: :desc)
    if params[:query].present?
      query = "%#{params[:query].strip.downcase}%"
      @articles = @articles.where("LOWER(title) LIKE ? OR LOWER(body) LIKE ?", query, query)
    end
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new(article_id: @article.id)
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Article not found."
    redirect_to articles_path
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article '#{@article.title}' was successfully published!"
      redirect_to article_path(@article)
    else
      flash.now[:alert] = "Please fix the errors below to publish your article."
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Article not found."
    redirect_to articles_path
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article '#{@article.title}' was successfully updated!"
      redirect_to article_path(@article)
    else
      flash.now[:alert] = "Please fix the errors below to update your article."
      render :edit
    end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Article not found."
    redirect_to articles_path
  end

  def destroy
    @article = Article.find(params[:id])
    title = @article.title
    @article.destroy

    flash[:notice] = "Article '#{title}' was successfully removed."
    redirect_to articles_path
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Article not found."
    redirect_to articles_path
  end
end
