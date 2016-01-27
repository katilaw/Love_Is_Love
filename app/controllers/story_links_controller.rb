class StoryLinksController < ApplicationController
  def new
    @story = Story.find(params[:story_id])
    @story_link = StoryLink.new
  end

  def create
    @story_link = StoryLink.new(story_link_params)

    if @story_link.save
      redirect_to story_path(@story_link.requestee_id),
        notice: 'Request processesed. Pending approval.'
    else
      flash.now[:error] = 'Please select a story!'
      render :new
    end
  end

  private

  def story_link_params
    params.require(:story_link).permit(:requestor_id, :requestee_id)
  end
end
