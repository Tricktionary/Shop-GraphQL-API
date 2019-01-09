class Resolvers::GetProduct < GraphQL::Function
 
  argument :id, !types.ID

  type Types::ProductType
  
  def call(_obj, args, _ctx)
    Product.find(args[:id])
  end
end