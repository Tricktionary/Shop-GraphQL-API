class Resolvers::AllProducts < GraphQL::Function
 
  argument :available, types.Boolean, default_value: false

  type Types::ProductType
  
  def call(_obj, args, _ctx)
    if args[:available]
      Product.where("inventory_count > ?", 0)
    else
      Product.all
    end 
  end
end