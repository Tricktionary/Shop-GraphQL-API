class Resolvers::PurchaseProduct < GraphQL::Function
  description "Purchase a single product from the referenced product\n

  ARGUMENTS \n\n
  - product_id(required): The id that reference the product you want to buy\n
  
  ERROR IF \n\n
  - The product_id is not valid \n
  - The product given is out of stock \n
  "

  argument :product_id, !types.ID
  
  type Types::ProductType
  
  def call(_obj, args, _ctx)
    product = Product.find_by(id: args[:product_id])

    if product 
      if product.inventory_count > 0 
        product.update(inventory_count: product.inventory_count - 1)
        product
      else 
        GraphQL::ExecutionError.new("The product no longer has available inventory") 
      end
    else
      GraphQL::ExecutionError.new("The product id is not valid") 
    end 
  end
end