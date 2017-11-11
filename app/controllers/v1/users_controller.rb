class V1::UsersController < V1::BaseController
  before_action :load_user, only: [:update, :show, :destroy]

  def index
    users = User.all
    user_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      users, each_serializer: UserSerializer)
    render json: success_message(t("v1.get_list_successfully", name: User),
      user_serializer)
  end

  def show
    render json: success_message(t("v1.show_successfully", name: User),
      user_serializer(@user))
  end

  def create
    user = User.new user_params
    if user.save
      render json: success_message(t("v1.create_successfully", name: User),
        user_serializer(user))
    else
      render json: error_message(t("v1.create_fails", name: User))
    end
  end

  def update
    @user.update_attributes user_params
    render json: success_message(t("v1.update_successfully", name: User),
      user_serializer(@user))
  end

  def destroy
    if @user.destroy
      render json: success_message(t("v1.delete_successfully", name: User),
        user_serializer(@user))
    else
      render json: error_message(t("v1.delete_fails", name: User), @user)
    end
  end

  private
  def load_user
    @user = User.find params[:id]
    unless @user
      render json: error_message(t("v1.not_found", name: User))
    end
  end

  def user_params
    params.permit :name, :email, :password, :phone, :role_id,
      :chatwork_id, :dept_id, :position_id
  end

  def user_serializer user
    UserSerializer.new(user).serializable_hash
  end
end
