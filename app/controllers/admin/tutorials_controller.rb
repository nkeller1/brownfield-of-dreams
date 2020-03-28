class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def show
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.create(tutorial_params)
    if tutorial.save
      flash[:success] = "Successfully created tutorial."
      redirect_to "/admin/tutorials/#{tutorial.id}"
    else
      flash[:error] = tutorial.errors.full_messages.to_sentence

      redirect_to '/admin/tutorials/new'
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    require "pry"; binding.pry
    Tutorial.destroy(params[:id])
    flash[:success] = "Tutorial Deleted."

    redirect_to '/admin/dashboard'
  end

  private
  def tutorial_params
    params.require(:tutorial).permit(:tag_list, :title, :description, :thumbnail)
  end
end
