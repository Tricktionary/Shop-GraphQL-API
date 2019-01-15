class Resolvers::UpdateProductTitle < GraphQL::Function
  description "Update the product title of the referenced product\n

  ARGUMENTS \n\n
  - product_id(required): The id that reference the product you want to buy\n
  - title(required): The title you want to update your product to be \n
  
  ERROR IF \n\n
  - The product_id is not valid \n
  - The title of the product doesn't exist or is empty \n
  "

  argument :product_id, !types.ID
  argument :title, !types.String

  type Types::ProductType
  
  def call(_obj, args, _ctx)
    product = Product.find_by(id: args[:product_id])
    
    if product
      if !args[:title].eql? ""
        product.update(title: args[:title])
        product
      else 
        GraphQL::ExecutionError.new("Cannot set an empty string as the product title")
      end 
    else
      GraphQL::ExecutionError.new("The product_id doesn't exist")
    end

  end
end