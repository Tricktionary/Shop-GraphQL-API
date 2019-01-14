Types::CartType = GraphQL::ObjectType.define do

  name 'Cart'

  field :id , !types.ID
  field :products, types[Types::ProductType]
  field :total_value, !types.Float
  field :completed, !types.Boolean
end 