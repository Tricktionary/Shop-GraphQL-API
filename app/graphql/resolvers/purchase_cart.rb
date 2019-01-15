class Resolvers::PurchaseCart < GraphQL::Function
  
  description "Purchases all the products in a cart\n\n

  ARGUMENTS\n\n
    - cart_id(required): An ID of the cart that is going to be purchased\n
  
  ERROR IF\n\n
  - the cart_id does not exist\n
  - the product's inventory_count is less than the carts wanted ammount of a product\n
  - the cart is already completed so it can no longer be purchased\n
  "
  
  argument :cart_id, types.ID

  type Types::CartType
  
  def call(_obj, args, _ctx)
    cart = Cart.find_by(id: args[:cart_id])
 
    if cart
      if cart.completed == false
        valid = validate_cart(cart)
        if valid
          for product in cart.products.uniq
            items = LineItem.where("cart_id=? AND product_id=?", cart.id, product.id)
            itemQuantity = 0
            
            for item in items
              itemQuantity = itemQuantity + item.quantity
            end
            #Purchase the products from the available inventory
            product.update(inventory_count: product.inventory_count - itemQuantity)
          end 
          cart.update(completed: true)
          cart
        else
          GraphQL::ExecutionError.new("There is no more stock left for one or more of the items in your cart") 
        end 
      else
        GraphQL::ExecutionError.new("The cart has already been purchased") 
      end 
    else
      GraphQL::ExecutionError.new("The cart referenced does not exist") 
    end 
    
      

  end

  #Validation of the carts products
  #Get all instances of a lineitem where it has a reference to this cart and product
  #Get the length of the number of line items and check if its greater than the current product inventory if not than its valid for purchase
  def validate_cart(cart)
      for product in cart.products.uniq
        items = LineItem.where("cart_id=? AND product_id=?", cart.id, product.id)
        itemQuantity = 0
        
        for item in items
          itemQuantity = itemQuantity + item.quantity
        end
        puts itemQuantity
        if itemQuantity > product.inventory_count
          return false
        end 
      end
      
      return true
  end 
end