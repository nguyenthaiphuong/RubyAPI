class V1::TimeRequestsController < V1::BaseController
  before_action :load_time_request, only: [:update, :show, :destroy]

  def index
    time_requests = TimeRequest.all
    request_serializer = ActiveModel::Serializer::CollectionSerializer.new(
      time_requests, each_serializer: TimeRequestSerializer)
    render json: success_message(t("v1.get_list_successfully", name: TimeRequest),
     request_serializer)
  end

  def show
    render json: success_message(t("v1.show_successfully", name: TimeRequest),
      request_serializer(@time_request))
  end

  def create
    time_request = TimeRequest.new time_request_params
    if time_request.save
      render json: success_message(t("v1.create_successfully", name: TimeRequest),
        request_serializer(@time_request))
    else
      render json: error_message(t("v1.create_fails", name: TimeRequest))
    end
  end

  def update
    @time_request.update_attributes time_request_params
    render json: success_message(t("v1.update_successfully", name: TimeRequest),
      request_serializer(@time_request))
  end

  def destroy
    if @time_request.destroy
      render json: success_message(t("v1.delete_successfully", name: TimeRequest),
        request_serializer(@time_request))
    else
      render json: error_message(t("v1.delete_fails", name: TimeRequest))
    end
  end

  private
  def time_request_params
    params.permit :ot_id, :user_id, :start_time, :end_time
  end

  def load_time_request
    @time_request = TimeRequest.find params[:id]
    unless @time_request
      render json: error_message(t("v1.not_found", name: TimeRequest))
    end
  end

  def request_serializer request
    TimeRequestSerializer.new(request)
  end
end
