module Api
  module Simple
    class OrderEntriesController < ApplicationController
      before_action :set_order_entry, only: [:show, :update]
      def create
        @order_entry = OrderEntry.new()
        @order_entry.vendor = params[:order_entry][:vendor]
        @order_entry.product_id = params[:order_entry][:product_id]
        @order_entry.order_id = params[:order_entry][:order_id]
        @order_entry.quoted_by = params[:order_entry][:quoted_by]
        @order_entry.price = params[:order_entry][:price]
        @order_entry.cost = params[:order_entry][:cost]
        @order_entry.tax = params[:order_entry][:tax]
        @order_entry.quantity = params[:order_entry][:quantity]
        if @order_entry.save
          render json: @order_entry
        else
          render nothing: true, status: :bad_request
        end
      end

      def update
        if params[:order_entry][:product_id] == ''
          params[:order_entry][:product_id] = @order_entry.product_id
        end
        if params[:order_entry][:vendor] == ''
          params[:order_entry][:vendor] = @order_entry.vendor
        end
        if params[:order_entry][:quoted_by] == ''
          params[:order_entry][:quoted_by] = @order_entry.quoted_by
        end
        if @order_entry.update_attributes(:vendor => params[:order_entry][:vendor], :product_id => params[:order_entry][:product_id], :order_id => params[:order_entry][:order_id], :quoted_by => params[:order_entry][:quoted_by], :price => params[:order_entry][:price], :tax => params[:order_entry][:tax], :cost => params[:order_entry][:cost], :quantity => params[:order_entry][:quantity])
          render :json => @order_entry, :status => :ok
        else
          render json: { status: 'failed' }, status: :unprocessable_entity
        end
      end
      def show
        render json: @order_entry,methods: [:vendor_name, :product_name, :quoted_name]
      end

      private

      def order_entry_params
          params[:order_entry]
      end

      def set_order_entry
        @order_entry = OrderEntry.find(params[:id])
      end

    end
  end
end