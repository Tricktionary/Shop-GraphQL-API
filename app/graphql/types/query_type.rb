Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  field :allProducts, function: Resolvers::AllProducts.new
  field :getProduct, function: Resolvers::GetProduct.new
end
