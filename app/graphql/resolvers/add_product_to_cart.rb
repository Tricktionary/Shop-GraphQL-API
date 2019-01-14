class Resolvers::AddProductToCart < GraphQL::Function
 
  argument :cartId, types.ID
  argument :product_id, types.ID
  argument :quantity, types.Int


  type Types::CartType
  
  def call(_obj, args, _ctx)
    cart = Cart.find(args[:cartId])
    product = Product.find(args[:product_id])
    quantity = args[:quantity]
    LineItem.create(cart: cart, product: product, quantity: quantity)
    cart
  end
end