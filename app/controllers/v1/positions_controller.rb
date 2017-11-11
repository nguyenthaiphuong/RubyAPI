class V1::PositionsController < V1::BaseController
  before_action :load_position, only: [:update, :show, :destroy]

  def index
    positions = Position.all
    position_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      positions, each_serializer: PositionSerializer)
    render json: success_message(t("v1.get_list_successfully", name: Position),
      position_serializer)
  end

  def show
    render json: success_message(t("v1.show_successfully", name: Position),
      position_serializer(position))
  end

  def create
    position = Position.new position_params
    if position.save
      render json: success_message(t("v1.create_successfully", name: Position),
        position_serializer(position))
    else
      render json: error_message(t("v1.create_fails", name: Position))
    end
  end

  def update
    @position.update_attributes position_params
    render json: success_message(t("v1.update_successfully", name: Position),
      position_serializer(@position))
  end

  def destroy
    if @position.destroy
      render json: success_message(t("v1.delete_successfully", name: Position),
        position_serializer(@position))
    else
      render json: error_message(t("v1.delete_fails", name: Position))
    end
  end

  private
  def load_position
    @position = Position.find params[:id]
    unless @position
      render json: error_message(t("v1.not_found", name: Position))
    end
  end

  def position_params
    params.permit :name
  end

  def position_serializer position
    PositionSerializer.new(position).serializable_hash
  end
end
