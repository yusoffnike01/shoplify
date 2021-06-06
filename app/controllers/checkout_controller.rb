class CheckoutController < ApplicationController
    def create
        @product=Product.find(params[:id])
        puts "===#{@product.name}==="
        puts "===#{@product.price}==="
        @session = Stripe::Checkout::Session.create({
                 customer: current_user.stripe_customer_id
                  payment_method_types: ['card'],
                 line_items: [{
                     name:@product.name,
                     amount:@product.price,
                     currency: "myr",
                     quantity: 1
                 }
                
                ],
                 mode: 'payment',
                success_url: root_url,
                cancel_url: root_url,
            })

            respond_to do |format|
                format.js
              end
    end
end