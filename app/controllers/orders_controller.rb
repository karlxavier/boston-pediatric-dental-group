class OrdersController < ApplicationController
     before_action :set_order, only: [:edit, :update, :destroy, :show]

     def index
        session[:supplier_id] = nil
        respond_to do |format|
            if params[:filter].present?
                if params[:filter].has_key?(:from_date) && params[:filter].has_key?(:to_date)
                    if params[:filter][:order_status] === "new"
                        order_status = :new_order
                    elsif params[:filter][:order_status] === "received"
                        order_status = :received
                    else
                        order_status = [:new_order, :processed, :received, :cancel]
                    end

                    from_date = !params[:filter][:from_date].blank? ? DateTime.parse(params[:filter][:from_date].to_s).to_date : DateTime.parse("1990-01-01".to_s).to_date
                    to_date = !params[:filter][:to_date].blank? ? DateTime.parse(params[:filter][:to_date].to_s).to_date : DateTime.parse("2022-12-31".to_s).to_date

                    @orders = Order.scope_filter_orders(order_status, from_date, to_date)
                else
                    if params[:filter][:order_status] === "new"
                        order_status = :new_order
                    elsif params[:filter][:order_status] === "received"
                        order_status = :received
                    else
                        order_status = [:new_order, :processed, :received, :cancel]
                    end

                    from_date = DateTime.parse("1990-01-01".to_s).to_date
                    to_date = DateTime.parse("2022-12-31".to_s).to_date

                    @orders = Order.scope_filter_orders(status, from_date, to_date)
                end
                format.js
            else
                @orders = Order.scope_orders
                format.html
            end
        end
     end

     def new
     end

     def edit
     end

     def create
          @order = current_user.orders.new(order_params)
          @order.invoice_number = "INV#{Order.last.present? ? (Order.last.id + 1).to_s.rjust(5, '0') : "00001"}"
          respond_to do |format|
             if @order.save
                  format.html { redirect_to orders_path }
              else
                  format.html { render 'new' }
              end
          end
     end

     def update

          respond_to do |format|
              if @order.update_attributes(order_params)
                  format.html { redirect_to orders_path }
              else
                  format.html { render 'edit' }
              end
          end
     end

     def supplier_info
          respond_to do |format|
               @supplier = Vendor.find(params[:supplier_id])
               @products = @supplier.products
               format.js
          end
     end

     def supplier_choose
          respond_to do |format|
               format.js
          end
     end

     def receive_product
        @order_product = OrderProduct.find(params[:order_product_id])
        @order = @order_product.order
        if @order_product.present?
            respond_to do |format|
                @order_product.update_attributes(status: 1, received_on: Time.now)

                inventory = Inventory.where(product_id: @order_product.product_id).first
                if inventory.present?
                    inventory.quantity = inventory.quantity.to_i + 1
                    inventory.save
                else
                    inventory =  Inventory.create(quantity: 1, product_id: @order_product.product_id)
                end

                inventory.inventory_details.create(order_id: @order.id)

                @order.update_attributes(status: 2)
                format.js
            end
        end
     end

    #  def supplier_products
    #     if params[:supplier_id]
    #         @supplier = Vendor.find(params[:supplier_id])
    #         @products = @supplier.products
    #         render json: @products.map{|v| v.serializable_hash(only: [:id, :name]) }
    #     else
    #         render json: []
    #     end
    #  end

    def product_info
        if params[:product_id]
            @product = Product.find(params[:product_id])
            if @product.present?
                render json: { status: 'success', product: @product.to_json }, status: :ok
            else
                render json: { status: 'error', message: 'Cannot find the product.' }, status: :unprocessable_entity
            end
        else
            render json: { status: 'error', message: 'Cannot find the product.' }, status: :unprocessable_entity
        end
    end

    def product_info_vc_code
        if params[:vc_code]
            @product = Product.where(vc_code: params[:vc_code])
            if @product.present?
                render json: { status: 'success', product: @product.first.to_json }, status: :ok
            else
                render json: { status: 'error', message: 'Cannot find the product.' }, status: :unprocessable_entity
            end
        else
            render json: { status: 'error', message: 'Cannot find the product.' }, status: :unprocessable_entity
        end
    end

    def product_mfg_code
        if params[:mfg_code]
            @product = Product.where(mfg_code: params[:mfg_code])
            if @product.present?
                render json: { status: 'success', product: @product.first.to_json }, status: :ok
            else
                render json: { status: 'error', message: 'Cannot find the product.' }, status: :unprocessable_entity
            end
        else
            render json: { status: 'error', message: 'Cannot find the product.' }, status: :unprocessable_entity
        end
    end

    def generate_pdf
        @order = Order.find(params[:order_id])

        respond_to do |format|
            format.html
            format.pdf do
                render pdf: "OrderNo:#{@order.id}",
                page_size: 'A4',
                template: "orders/generate_pdf.html.erb",
                layout: "pdf.html",
                print_media_type: true,
                lowquality: true,
                zoom: 1,
                dpi: 75
            end
        end
    end

     private
     
     def order_params
          params.require(:order).permit(
               :user_id, :vendor_id, :notes, :status, :invoice_number, office_ids: [],
               order_products_attributes: [:id, :order_id, :product_id, :_destroy, :vc_code, :mfg_code],
               order_attachments_attributes: [:id, :order_id, :attachment, :_destroy]
          )
     end

     def set_order
          @order = Order.find(params[:id])
     end

end