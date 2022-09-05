class Api::V1::OrdersController < ApplicationController
  include Paginable
  before_action :check_login, only: %i[index]

  def index
    @orders = current_user.orders
                          .page(current_page) 
                          .per(per_page)
    options = { 
      links: {
        first: api_v1_orders_path(page: 1),
        last: api_v1_orders_path(page: @orders.total_pages), 
        prev: api_v1_orders_path(page: @orders.prev_page), 
        next: api_v1_orders_path(page: @orders.next_page),
      } 
    }
    # render json: OrderSerializer.new(current_user.orders).serializable_hash
    render json: OrderSerializer.new(@orders, options).serializable_hash
  end

  def show
    # order = current_user.orders.find(params[:id]) 
    order = current_user.orders.find(order_params) 
    if order.save
      # options = { include: [:products] }
      # render json: OrderSerializer.new(order, options).serializable_hash
      render json: order, status: 201
    else 
    #  head 404
    render json: { errors: order.errors }, status: 422
    end
  end

  def create
    # order = current_user.orders.build(order_params) 
    order = Order.create! user: current_user
    order.build_placements_with_product_ids_and_quantities 
      (order_params[:product_ids_and_quantities])

    if order.save
      # OrderMailer.send_confirmation(order).deliver 
      # render json: order, status: 201

      OrderMailer.send_confirmation(order).deliver 
      render json: order, status: :created
    else
      # render json: { errors: order.errors }, status: 422
      render json: { errors: order.errors }, status: :unprocessable_entity 
    end
  end

  private

  def order_params
    # params.require(:order).permit(:total, product_ids: [])
    params.require(:order).permit(product_ids_and_quantities: [:product_id, :quantity])
  end
end