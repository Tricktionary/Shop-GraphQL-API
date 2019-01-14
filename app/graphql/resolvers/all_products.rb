class Resolvers::AllProducts < GraphQL::Function
  
  description "Retrieve all products with an available inventory\n

  ARGUMENTS \n\n
  - available(default=false): When set to true returns all elements that have an available inventory
  "
  
  argument :available, types.Boolean, default_value: false

  type types[Types::ProductType]
  
  def call(_obj, args, _ctx)
    if args[:available]
      Product.where("inventory_count > ?", 0)
    else
      Product.all
    end 
  end
end