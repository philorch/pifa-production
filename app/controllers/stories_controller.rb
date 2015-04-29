class StoriesController < AdminPanelController
  
  def index
    @stories = Story.all
  end
  
  def show
    @story = Story.find(params[:id])
  end
  
  def new
    @story = Story.new
  end
  
  def create
    @story = Story.new(params[:story])
    if @story.save
      redirect_to @story, :notice => "Successfully created story."
    else
      render :action => 'new'
    end
  end
  
  def edit
    @story = Story.find(params[:id])
  end
  
  def update
    @story = Story.find(params[:id])
    if @story.update_attributes(params[:story])
      redirect_to @story, :notice => "Successfully updated story."
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to stories_path
  end
  
end