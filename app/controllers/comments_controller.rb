class CommentsController < ApplicationController

  def new
    if user_signed_in?
      @story = Story.find(params[:story_id])
      @comment = Comment.new
    else
      @story = Story.find(params[:story_id])
      flash[:error] = "You must be signed in to add a comment!"
      redirect_to story_comments_path(@story)
    end
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

  def edit
    @comment = Comment.find(params[:id])
    @story = Story.find(params[:story_id])
  end

  def update
    @story = Story.find(params[:story_id])
    @comment = Comment.new(comment_params)
    @comment.story = @story

    if @comment.update_attributes(comment_params)
      redirect_to @story, notice: 'Comment Updated!'
    else
      flash.now[:error] = "Comment can't be blank!"
      render :edit
    end
  end

  def destroy
    @story = Story.find(params[:story_id])
    @comment = Comment.destroy(params[:id])
    redirect_to story_path(@story),
      notice: select_message
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :creator_id)
  end

  def authorize_user
    if !user_signed_in?
      raise ActionController::RoutingError.new("Not Found")
    end
  end

  def select_message
    if @comment.story.creator == current_user
      "You've removed an unwanted comment."
    else
      'Comment Deleted!'
    end
  end
end
