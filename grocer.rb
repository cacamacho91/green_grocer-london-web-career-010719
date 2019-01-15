require 'pry'

def consolidate_cart(cart)
  cart_histogram = {}
  cart.each do |item|
    item.each do |name, data|
      if cart_histogram.keys.include?(name)
        cart_histogram[name][:count] += 1
      else
        cart_histogram[name] = { price: data[:price], clearance: data[:clearance], count: 1 }
      end
    end
  end
  cart_histogram
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    match = cart.find {|item_name, item_data| item_name == coupon[:item]}
    if match && cart[match[0]][:count] >= coupon[:num]
      if cart[match[0] + " W/COUPON"]
        cart[match[0] + " W/COUPON"][:count] += 1
      else
        cart[match[0] + " W/COUPON"] = {price: coupon[:cost], count: 1, clearance: cart[match[0]][:clearance]}
      end
      cart[match[0]][:count] -= coupon[:num]
    end
  end
  cart
end

#something very strange is happening here > to fixß
def apply_clearance(cart)
  discounted_cart = {}
  cart.each do |item_name, item_data|
    item_data[:price] = (item_data[:price]*=0.8).round(1) if item_data[:clearance]
    discounted_cart[item_name] = item_data
  end
  discounted_cart
end

def checkout(cart, coupons)
  total_cost = 0
  cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))

  cart.each {|item_name, item_data| total_cost += item_data[:price] * item_data[:count]}
  total_cost *= 0.9 if total_cost > 100
  total_cost
end
