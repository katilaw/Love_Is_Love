class CommentsController < ApplicationController

  def new
    @story = Story.find(params[:story_id])
    @comment = Comment.new
  end

  def create
    @story = Story.find(params[:story_id])
    @comment = Comment.new(comment_params)
    @comment.story = @story
    
    if @comment.save
      redirect_to story_path(@story), notice: 'Comment Posted!'
    else
      flash.now[:error] = "Comment can't be blank!"
      render :new
    end
  end
  private

  def comment_params
    params.require(:comment).permit(:body, :creator_id)
  end
end
