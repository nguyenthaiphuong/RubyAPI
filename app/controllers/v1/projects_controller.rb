class V1::ProjectsController < V1::BaseController
  before_action :load_project, only: [:update, :show, :destroy]

  def index
    projects = Project.all
    project_serializer  = ActiveModel::Serializer::CollectionSerializer.new(
      projects, each_serializer: ProjectSerializer)
    render json: success_message(t("v1.get_list_successfully", name: Project),
      project_serializer)
  end

  def show
    render json: success_message(t("v1.show_successfully", name: Project),
      project_serializer(@project))
  end

  def create
    project = Project.new project_params
    if project.save
      render json: success_message(t("v1.create_successfully", name: Project),
        project_serializer(project))
    else
      render json: error_message(t("v1.create_fails", name: Project))
    end
  end

  def update
    @project.update_attributes project_params
    render json: success_message(t("v1.update_successfully", name: Project),
      project_serializer(@project))
  end

  def destroy
    if @project.destroy
      render json: success_message(t("v1.delete_successfully", Project),
        project_serializer(@project))
    else
      render json: error_message(t("v1.delete_fails", Project))
    end
  end

  private
  def project_params
    params.permit :name, :description
  end

  def load_project
    @project = Project.find params[:id]
    unless @project
      render json: error_message(t("v1.not_found"), Project)
    end
  end

  def project_serializer project
    ProjectSerializer.new(project).serializable_hash
  end
end
