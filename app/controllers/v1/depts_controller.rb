class V1::DeptsController < V1::BaseController
  before_action :load_dept, only: [:update, :show, :destroy]

  def index
    @depts = Dept.all
    dept_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      @depts, each_serializer: DeptSerializer)
    render json: success_message(t("v1.get_list_successfully", name: Dept),
      dept_serializer)
  end

  def show
    render json: success_message(t("v1.show_successfully", name: Dept),
      dept_serializer(@dept))
  end

  def create
    dept = Dept.new(dept_params)
    if dept.save
      render json: success_message(t("v1.create_successfully", Dept),
        dept_serializer(dept))
    else
      render json: error_message(t("v1.create_fails", name: Dept))
    end
  end

  def update
    @dept.update_attributes dept_params
    render json: success_message(t("v1.update_successfully", name: Dept),
      dept_serializer(@dept))
  end

  def destroy
    if @dept.destroy
      dept_serializer = Dept.new(@dept).serializable_hash
      render json: success_message(t("v1.delete_successfully", name: Dept),
        dept_serializer(@dept))
    else
      render json: error_message(t("v1.delete_fails", name: Dept))
    end
  end

  private
  def load_dept
    @dept = Dept.find params[:id]
    unless @dept
      render json: error_message(t("v1.not_found", name: Dept))
    end
  end

  def dept_params
    params.permit :name
  end

  def dept_serializer dept
    DeptSerializer.new(dept).serializable_hash
  end
end
