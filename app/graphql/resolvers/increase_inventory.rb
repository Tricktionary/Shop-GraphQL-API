class Resolvers::IncreaseInventory < GraphQL::Function
 
  argument :product_id, types.ID
  argument :new_inventory, types.Int

  type Types::ProductType
  
  def call(_obj, args, _ctx)
    product = Product.find(args[:product_id])
    product.update(inventory_count: product.inventory_count + args[:new_inventory])
    product
  end
end