require 'pry'

def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item|
    item.each do |item_name, item_data|
      #check if item is in the consolidated_cart
      # > if it is increment the count
      # > if it is not add it to the cart with a count of 1
      if new_cart.keys.include?(item_name)
        new_cart[item_name][:count] += 1
      else
        new_cart[item_name] = {
          price: item_data[:price],
          clearance: item_data[:clearance],
          count: 1
        }
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  new_cart = {}
  cart.each do |item_name, item_data|

    #check if there is a coupon that exisits for the item
    coupons.each do |coupon|
      if coupon[:item] == item_name
        #add the numebr of items on the coupon to the cart at a reduced price and the rest at a regular price
        new_cart["#{item_name} W/COUPON"] = {
          price: coupon[:cost],
          clearance: item_data[:clearance],
          count: 1
        }
        new_cart[item_name] = {
          price: item_data[:price],
          clearance: item_data[:clearance],
          count: (item_data[:count]-coupon[:num])
        }
      end
    end
  end
  new_cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
