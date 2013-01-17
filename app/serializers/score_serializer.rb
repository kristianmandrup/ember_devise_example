class ScoreSerializer < ActiveModel::Serializer
  attributes :id, :when, :what, :user_id
end
