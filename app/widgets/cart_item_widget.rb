# class CartItemWidget < Apotomo::Widget
# 
#   def new args
# p 1
#     user    = args[:user]
#     @cart = user ? (user.current_cart || user.carts.new) : Cart.new
#     @committee = args[:committee]
# p user
# p user.current_cart
# p @cart
# p 'compare'
# p @cart.committees
# p @committee
#     @present = @committee and @cart.committees.include?(@committee)
# p 'present', @present
#     
#     render
#   end
#   
#   def create args
# p 2
# raise 2
#     user    = args[:user]
#     @cart = user ? (user.current_cart || user.carts.create) : Cart.create
#     @committee = Committee.find args[:committee_id]
#     ci = @cart.cart_item.build
#     ci.committee = @committee
#     @cart.save!
# p @cart
# p @commitee    
#     
#     update :state => :new
#   end
# 
#   def destroy
#   end
# 
#   def update
#   end
# 
# end
