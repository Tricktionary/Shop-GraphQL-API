class Resolvers::CreateCart < GraphQL::Function
 
  description "Create a cart object\n"

  type Types::CartType
  
  def call(_obj, args, _ctx)
    cart = Cart.create(total_value:0 ,completed: false)
    cart
  end
end