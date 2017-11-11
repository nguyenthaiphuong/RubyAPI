class OtSerializer < ActiveModel::Serializer
  attributes :id, :user, :project, :description, :date, :start_time, :end_time,
    :time_requests

  def date
    object.date.to_i
  end

  def start_time
    object.start_time.to_i
  end

  def end_time
    object.end_time.to_i
  end

  def time_requests
    ActiveModel::Serializer::CollectionSerializer.new(
      object.time_requests, each_serializer: TimeRequestSerializer)
  end

end
