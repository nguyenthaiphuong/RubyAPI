class V1::OtsController < V1::BaseController
  before_action :load_ot, only: [:update, :show, :destroy]

  def index
    ots = Ot.all
    ot_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      ots, each_serializer: OtSerializer)
    render json: success_message(t("v1.get_list_successfully", name: Ot),
      ot_serializer)
  end

  def show
    render json: success_message(t("v1.show_successfully", name: Ot),
      ot_serializer(@ot))
  end

  def create
    ot = Ot.new ot_params
    if ot.save
      render json: success_message(t("v1.create_successfully", name: Ot),
        ot_serializer(ot))
    else
      render json: error_message(t("v1.create_fails", name: Ot))
    end
  end

  def update
    @ot.update_attributes ot_params
    render json: success_message(t("v1.update_successfully", name: Ot),
      ot_serializer(@ot))
  end

  def destroy
    if @ot.destroy
      render json: success_message(t("v1.delete_successfully", name: Ot),
        ot_serializer(@ot))
    else
      render json: error_message(t("v1.delete_fails", name: Ot))
    end
  end

  private
  def ot_params
    params.permit :user_id, :project_id, :description, :date, :start_time, :end_time
  end

  def load_ot
    @ot = Ot.find params[:id]
    unless @ot
      render json: error_message(t("v1.not_found", name: Ot))
    end
  end

  def ot_serializer ot
    OtSerializer.new(ot).serializable_hash
  end
end
