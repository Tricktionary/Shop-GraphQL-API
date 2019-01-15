Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"
  
  description "
    All the operations that change or remove the data that exist in the database
  "
  
  field :purchaseProduct, function: Resolvers::PurchaseProduct.new
  field :addProductToCart, function: Resolvers::AddProductToCart.new
  field :createCart, function: Resolvers::CreateCart.new
  field :createProduct, function: Resolvers::CreateProduct.new
  field :purchaseCart, function: Resolvers::PurchaseCart.new
  field :increaseInventory, function: Resolvers::IncreaseInventory.new
  field :updateProductTitle, function: Resolvers::UpdateProductTitle.new
  field :removeCart, function: Resolvers::RemoveCart.new
  field :removeProduct, function: Resolvers::RemoveProduct.new
end
