class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)

    if @comment.save
      flash[:notice] = "Your comment has been posted!"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Failed to post comment: #{@comment.errors.full_messages.join(', ')}"
      redirect_to article_path(@article)
    end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Article not found."
    redirect_to articles_path
  end

  private

  def comment_params
    params.require(:comment).permit(:author_name, :body)
  end
end
