class Resolvers::GetProduct < GraphQL::Function
  description "Get a product object\n

  ARGUMENTS \n\n
  - product_id(required): The id that reference the product you want to return\n\n

  ERROR IF \n\n
  - The product_id passed in is not valid \n
  "
  argument :product_id, !types.ID

  type Types::ProductType
  
  def call(_obj, args, _ctx)
    product = Product.find_by(id: args[:product_id])
    if product
      product
    else 
      GraphQL::ExecutionError.new("The product id doesn't exist")
    end 
  end
end