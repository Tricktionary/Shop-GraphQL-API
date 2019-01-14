class Resolvers::PurchaseProduct < GraphQL::Function
 
  argument :product_id, !types.ID

  type Types::ProductType
  
  def call(_obj, args, _ctx)
    product = Product.find(args[:product_id])
    if product.inventory_count > 0 
      product.update(inventory_count: product.inventory_count - 1)
    end 
    product
  end
end