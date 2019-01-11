class Resolvers::PurchaseCart < GraphQL::Function
 
  argument :cartId, types.ID

  type Types::CartType
  
  def call(_obj, args, _ctx)
    cart = Cart.find(args[:cartId])
     

    for product in cart.products
      item = LineItem.find(cart: cart, product: product)
    
      if product.inventory_count < item.quantity
        break
      else 
        product.inventory_count - item.quantity
      end 
      
    end 
    
    cart
  end
end