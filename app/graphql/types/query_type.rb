Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "All operations related in retrieving object data"
  field :allProducts, function: Resolvers::AllProducts.new
  field :getProduct, function: Resolvers::GetProduct.new
  field :getCart, function: Resolvers::GetCart.new
end
