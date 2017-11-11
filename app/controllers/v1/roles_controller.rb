class V1::RolesController < V1::BaseController
  before_action :load_role, only: [:update, :show, :delete]

  def index
    roles = Role.all
    role_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      roles, each_serializer: RoleSerializer)
    render json: success_message(t("v1.get_list_successfully)", name: Role),
      role_serializer)
  end

  def show
    render json: success_message(t("v1.show_successfully", name: Role),
      role_serializer(@role))
  end

  def create
    role = role.new role_params
    if role.save
      render json: success_message(t("v1.create_successfully", name: Role),
        role_serializer(role))
    else
      render json: error_message(t("v1.create_fails", name: role))
    end
  end

  def update
    @role.update_attributes role_params
    render json: success_message(t("v1.update_successfully", name: Role), role_serializer(@role))
  end

  def delete
    if @role.destroy
      render json: success_message(t("v1.delete_successfully", name: Role), role_serializer(@role))
    else
      render json: error_message(t("v1.delete_fails", name: Role))
    end
  end

  private
  def role_params
    params.permit :name
  end

  def load_role
    @role = Role.find params[:id]
    unless @role
      render json: error_message(t("v1.not_found", name: Role))
    end
  end

  def role_serializer role
    RoleSerializer.new(role).serializable_hash
  end
end
