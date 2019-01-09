Types::ProductType = GraphQL::ObjectType.define do

  name 'Product'

  field :id , !types.ID
  field :title, !types.String
  field :price, !types.Float
  field :inventory_count, !types.Int
end 