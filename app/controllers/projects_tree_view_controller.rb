class ProjectsTreeViewController < ApplicationController

  helper :projects

  def index
    scope = Project.visible.sorted

    respond_to do |format|
      format.html {
        unless params[:closed]
          scope = scope.active
        end
        @projects = scope.to_a
      }
    end
  end

end

