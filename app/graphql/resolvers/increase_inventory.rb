class Resolvers::IncreaseInventory < GraphQL::Function
  description "Increase in inventory_count of a product object by the value of new_inventory\n

  ARGUMENTS \n\n
  - product_id(required): The id that reference the product you want to increment the id of\n
  - new_inventory(required): The amount of new inventory you want to add to a product object\n

  ERROR IF \n\n
  - The product_id passed in is not valid \n
  - The new inventory is less than 0\n
  "
  argument :product_id, types.ID
  argument :new_inventory, types.Int

  type Types::ProductType
  
  def call(_obj, args, _ctx)
    product = Product.find_by(id: args[:product_id])

    if product
      if args[:new_inventory] >= 0
        product.update(inventory_count: product.inventory_count + args[:new_inventory])
        product
      else
        GraphQL::ExecutionError.new("The new inventory cannot be a negative number")
      end 
    else
      GraphQL::ExecutionError.new("The product id doesn't exist")
    end 
  end
end