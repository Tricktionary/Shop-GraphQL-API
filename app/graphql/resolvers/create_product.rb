class Resolvers::CreateProduct < GraphQL::Function
  description "Create a product object\n

  ARGUMENTS \n\n
  - title(required): An ID that represents the cart we want to add products to \n
  - price(required): An ID for the product that you would like to be added to the cart \n
  - quantity(required): The number of the product you want to add to your cart \n\n

  ERROR IF \n\n
  - The cart_id passed in is not valid \n
  - The price passed in is less than 0 \n
  - The quantity given is less than 0 \n
  "

  argument :title, types.String
  argument :price, types.Float
  argument :inventory_count, types.Int

  type Types::ProductType
  
  def call(_obj, args, _ctx)
    #Validation
    if args[:price] >= 0
      if args[:inventory_count] > 0
        product = Product.create(title: args[:title], price: args[:price], inventory_count: args[:inventory_count])
        product
      else
        GraphQL::ExecutionError.new("The inventory given must be greater than or equal to 0")
      end
    else
      GraphQL::ExecutionError.new("The price given is not valid must be greater than 0 or equal to 0")
    end 
  end
end