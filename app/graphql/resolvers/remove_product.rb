class Resolvers::RemoveProduct < GraphQL::Function
  description "Remove a Product from the database and all instances of it in a cart \n\n

  ARGUMENTS \n\n
  - product_id(required): An ID that represents the product that is going to be removed 

  ERROR IF \n\n
  - The product_id does not exist \n
  "

  argument :product_id, !types.ID

  type Types::ProductType

  def call(_obj, args, _ctx)
    product = Product.find_by(id: args[:product_id])
    if product
      product.destroy
      product
    else
      GraphQL::ExecutionError.new("The product_id does not exist ")
    end 
  end 
end 