class Users::ProductsController < ApplicationController
# before_action :authenticate_user!
before_action :set_product, only: [:show, :edit, :item_details]

	def item_details
		respond_to do |format|
			# @order_entry
			@messages = ItemMessage.where(product_id: @order_entry.product_id)
			# @messages = @product.item_messages

			format.js
		end
  end

  def change_picture
    if params[:product_id].present? && !params[:product_id].nil?
      @product = Product.find(params[:product_id])
      if @product.update_attributes(:picture => (params[:picture].nil? ? params[:file] : params[:picture]))
        render json: @product,methods: [:picture_url]
      else
        render nothing: true, status: :bad_request
      end
    else
      render nothing: true, status: :bad_request
    end
  end

  def create
    @product = Product.new
    @product.name = params[:product_name]
    @product.category = params[:category_id]
    @product.item_category_id = params[:item_category_id]
    @product.specs = params[:specs]
    @product.vendor_quote_prices = params[:vendor_quote_prices]
    @product.notes = params[:notes]
    @product.dynamic_fields = params[:dynamic_fields].to_s
    # @product.vendor_id = params[:vendor_id]
    if @product.save
      #Add Product on Inventory
      Inventory.create(:product_id => @product.id)
      #Add Vendor on List
      @order_entry_id = nil
      if params[:order_id].present?
        @order_entry = OrderEntry.new
        @order_entry.order_id = params[:order_id]
        @order_entry.product_id = @product.id
        @order_entry.quoted_by = params[:quoted_by]
        @order_entry.category_id = params[:item_category_id]
        @order_entry.price = params[:price]
        @order_entry.cost = params[:cost]
        @order_entry.quantity = params[:quantity]
        @order_entry.specs = params[:specs]
        @order_entry.vendor_quote_prices = [:vendor_quote_prices]
        @order_entry.notes = [:notes]
        @order_entry.dynamic_fields = params[:dynamic_fields].to_s
        if @order_entry.save
          @order_entry_id = @order_entry.id
        end
      end

      if params[:vendor_id].present?
        if params[:vendor_id].length > 0
          params[:vendor_id].each do |id|
            if !id.nil? && id != '' && id != ' '
              if @order_entry_id.nil?
                OrderEntryVendor.create(:product_id => @product.id, :vendor_id => id)
              else
                OrderEntryVendor.create(:order_entry_id => @order_entry_id,:product_id => @product.id, :vendor_id => id)
              end
            end
          end
        end
      end
      if params[:file].present?
        params[:file].each do |attachment_file|
          if @order_entry_id.nil?
            OrderEntryAttachment.create(:product_id => @product.id, :attachment_file => params[:file]["#{attachment_file}"])
          else
            OrderEntryAttachment.create(:order_entry_id => @order_entry_id, :product_id => @product.id, :attachment_file => params[:file]["#{attachment_file}"])
          end
        end
      end
      flash[:notice] = "Product Item has saved successfully."
    else
      flash[:error] = "Product Item save Failed!"
    end
    if params[:current_controller] == "inventories"
      redirect_to view_stocks_inventories_path
    else
      redirect_to users_orders_path
    end
  end

	private

		def set_product
			@order_entry = OrderEntry.find(params[:id])
			@product = Product.find(@order_entry.product_id)
			@order = Order.find(@order_entry.order_id)
		end

end