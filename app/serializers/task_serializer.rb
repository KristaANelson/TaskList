class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :due_date
end
