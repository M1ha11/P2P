class ClaimSerializer < ActiveModel::Serializer
  attributes :id, :amount, :currency, :goal
end
