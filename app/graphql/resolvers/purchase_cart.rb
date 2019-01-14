class Resolvers::PurchaseCart < GraphQL::Function
 
  argument :cartId, types.ID

  type Types::CartType
  
  def call(_obj, args, _ctx)
    cart = Cart.find(args[:cartId])
  
    valid = true
    for product in cart.products
      item = LineItem.find_by(cart: cart, product: product)
      if product.inventory_count < item.quantity
        valid = false
      end
    end 

    if valid 
      for product in cart.products
        item = LineItem.find_by(cart: cart, product: product)
        product.inventory_count - item.quantity
        product.update(inventory_count: product.inventory_count - item.quantity)
      end 
      cart.update(completed: true)
    else 
      cart 
    end 

  end
end