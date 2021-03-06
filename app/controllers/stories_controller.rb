class StoriesController < ApplicationController
  before_action :authorize_user, except: [:index, :show, :new, :create]

  def index
    if user_signed_in?
      @stories = Story.order(created_at: :desc)
      @links = StoryLink.where(user_id: current_user.id)
    else
      @stories = Story.order(created_at: :desc).limit(6)
    end
  end

  def show
    @story = Story.find(params[:id])
    @comment = Comment.new
    if user_signed_in?
      @comments = @story.comments.order(created_at: :desc)
      @current_user_stories = Story.where(creator_id: current_user.id)
      @links = StoryLink.where(user_id:
        current_user.id, requestor_id: params[:id])
    end
  end

  def new
    if user_signed_in?
      @story = Story.new
    else
      flash[:error] = "You must be signed in to add a story!"
      redirect_to stories_path
    end
  end

  def create
    @story = Story.new(story_params)
    @user = current_user
    @story.creator = @user

    if @story.save
      redirect_to story_path(@story),
        notice: 'Story Created Successfully!'
    else
      flash.now[:error] = "Oops! You forgot 1 or more required fields."
      render :new
    end
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])

    if @story.update_attributes(story_params)
      redirect_to @story, notice:
      "Looking good! Story Edited Successfully."
    else
      flash.now[:error] = 'Oops! Please fill in all
        required fields and try again.'
      render :edit
    end
  end

  def destroy
    @story = Story.find(params[:id])

    @story.comments.each do |comment|
      comment.destroy
    end

    @links = StoryLink.where(user_id:
      current_user.id, requestor_id: @story.id)
    @links.each do |link|
      link.destroy
    end

    @story.destroy

    redirect_to root_path,
      notice: "Your story was safely erased"
  end

  private

  def story_params
    params.require(:story).permit(:title, :body, :creator_id, :story_photo)
  end

  def authorize_user
    if !user_signed_in?
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
