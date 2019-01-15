class Resolvers::RemoveCart < GraphQL::Function
  description "Remove a Cart from the database \n\n
  ARGUMENTS \n\n 
  - cart_id(required): An ID of the cart that is going to be removed\n

  ERROR IF \n\n 
  - The cart_id does not exist 
  "

  argument :cart_id, !types.ID

  type Types::CartType
  
  def call(_obj, args, _ctx)
    cart = Cart.find_by(id: args[:cart_id])

    if cart
      cart.destroy
      cart
    else 
      GraphQL::ExecutionError.new("The cart_id does not exist ")
    end
  
  end
end 