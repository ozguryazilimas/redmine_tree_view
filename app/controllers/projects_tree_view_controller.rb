class ProjectsTreeViewController < ApplicationController

  helper :projects

  def index
    scope = Project.visible.sorted

    respond_to do |format|
      format.html {
        unless params[:closed]
          scope = scope.active
        end
        @project_ids = scope.pluck(:id)
        @projects = scope.to_a
      }
    end
  end

end

