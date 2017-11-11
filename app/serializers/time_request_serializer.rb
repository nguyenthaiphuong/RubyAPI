class TimeRequestSerializer < ActiveModel::Serializer
  attributes :id, :user, :ot, :start_time, :end_time

  def user
    object.user
  end

  def ot
    object.ot
  end
end
