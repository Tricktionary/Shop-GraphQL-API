class Resolvers::AddProductToCart < GraphQL::Function
 
  argument :cartId, types.ID
  argument :productId, types.ID
  argument :quantity, types.Int


  type Types::CartType
  
  def call(_obj, args, _ctx)
    cart = Cart.find(args[:cartId])
    product = Product.find(args[:productId])
    quantity = args[:quantity]
    order = Order.new(cart: cart, product: product, quantity: quantity)
    cart.orders << order
    cart
  end
end