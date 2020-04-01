class TutorialsController < ApplicationController
  # def index
  #   if params[:tag]
  #     @tutorials = Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
  #   else
  #     @tutorials = Tutorial.all.paginate(page: params[:page], per_page: 5)
  #   end
  # end

  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
