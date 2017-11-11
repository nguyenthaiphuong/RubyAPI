class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :chatwork_id, :dept, :position, :phone, :role

  def dept
    object.dept
  end

  def position
    object.position
  end

  def role
    object.role
  end
end
