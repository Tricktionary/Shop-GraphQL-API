Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :purchaseProduct, function: Resolvers::PurchaseProduct.new
  field :addProductToCart, function: Resolvers::AddProductToCart.new
  field :createCart, function: Resolvers::CreateCart.new
  field :createProduct, function: Resolvers::CreateProduct.new
  field :purchaseCart, function: Resolvers::PurchaseCart.new
  field :increaseInventory, function: Resolvers::IncreaseInventory.new
end
