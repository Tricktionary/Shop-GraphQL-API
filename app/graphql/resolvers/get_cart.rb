class Resolvers::GetCart < GraphQL::Function
  
  description "Retrieve the Cart based on the inputed ID\n\n
  
  ARGUMENTS\n\n
  - cart_id(required): An ID that represents the cart that wants to be retrieved

  ERROR IF \n\n
  - The cart_id does not exist
  "
  
  argument :cart_id, !types.ID

  type Types::CartType

  def call(_obj, args, _ctx)
    cart = Cart.find_by(id: args[:cart_id])
    
    #Validation 
    if cart
      cart
    else 
      GraphQL::ExecutionError.new("The given cart_id does not exist")
    end 

  end 
end
