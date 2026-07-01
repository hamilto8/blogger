class TagsController < ApplicationController
  def index
    @tags = Tag.order(:name)
  end

  def show
    @tag = Tag.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Tag not found."
    redirect_to tags_path
  end

  def destroy
    @tag = Tag.find(params[:id])
    name = @tag.name
    @tag.destroy

    flash[:notice] = "Tag '#{name}' was successfully removed."
    redirect_to tags_path
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Tag not found."
    redirect_to tags_path
  end
end
