class Resolvers::AddProductToCart < GraphQL::Function
  
  description "Add a products to a given cart and updates the value of the cart\n\n

  ARGUMENTS \n\n
  - cart_id(required): An ID that represents the cart we want to add products to \n
  - product_id(required): An ID for the product that you would like to be added to the cart \n
  - quantity(required): The number of the product you want to add to your cart \n\n

  ERROR IF \n\n
  - The cart_id passed in is not valid \n
  - The product_id passed in is not valid \n
  - The quantity givem is less than or equal to 0 \n
  "
  
  argument :cart_id, !types.ID
  argument :product_id, !types.ID
  argument :quantity, types.Int , default_value: 1


  type Types::CartType
  
  def call(_obj, args, _ctx)
    cart = Cart.find_by(id: args[:cart_id])
    product = Product.find_by(id: args[:product_id])
    quantity = args[:quantity]

    #Validation before adding a product to the cart 
    if cart 
      if product
        if quantity >=0
          LineItem.create(cart: cart, product: product, quantity: quantity)
          cart.update(total_value: (cart.total_value + (product.price * quantity)).round(2) )
          cart
        else 
          GraphQL::ExecutionError.new("The quantity given is not valid must be greater than 0")
        end
      else
        GraphQL::ExecutionError.new("The given product does not exist")
      end
    else 
      GraphQL::ExecutionError.new("The given cart does not exist")
    end 
  end
end