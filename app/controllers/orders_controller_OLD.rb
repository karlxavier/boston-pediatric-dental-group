class OrdersController < ApplicationController
  before_action :set_order, only: [:index, :show]
  before_action :set_search, only: :index
  before_action :set_chatroom, only: [:load_messages]
  respond_to :js, only: :index

  def send_orders
    @order = Order.find(params[:order_id].to_i)
    @vendor = Vendor.find(params[:vendor_id].to_i)
    @order_entries = OrderEntry.where(:order_id => @order.id, :vendor_id => @vendor.id)
    OrderMailer.with(order: @order, vendor: @vendor, order_entries: @order_entries).send_order_entries.deliver_now
    redirect_to admin_order_path(@order)
  end

  def index
    @orders = OrderSearchService.call(query: @search.term, sort_column: sort_column, sort_direction: sort_direction)
    if @orders.present? && !@orders.nil?
      if @order.present?
        @order_entries = @order.order_entries.order("updated_at DESC")
      else
        @order = Order.order(updated_at: :desc, created_at: :desc).first
        @order_entries = @order.order_entries.order("updated_at DESC")
      end
    end

    if params[:id].present?
      @order = Order.find(params[:id])
      @order_entries = @order.order_entries.order("updated_at DESC")
    end

    if params[:product_id].present?
      @product_id = params[:product_id]
    end
    if params[:order_entry_id].present?
      @order_entry_id = params[:order_entry_id]
    end
    @chatroom_order = @order.present? ? ChatroomOrder.find(@order.id) : ChatroomOrder.first
    @chatroom_orders = ChatroomOrder.order(id: :desc)
    @categories = Category.all
    @vendors = Vendor.all
    @products = Product.all
    @brands = Brand.all
    @order_histories = @order.present? ? OrderHistory.where(:order_id => @order.id).order("created_at DESC") : OrderHistory.first
  end

  def show
    respond_to do |format|
      @chatroom_order = ChatroomOrder.find(@order.id)
      @order_entries = @order.order_entries.order("updated_at DESC")
      @order_histories = OrderHistory.where(:order_id => @order.id).order("created_at DESC")

      format.js
    end
  end

  def new

  end

  def update_assign_user
    @order = Order.find(params[:order_user][:order_id])
    if @order.present?
      OrderUser.where(:order_id => @order.id).destroy_all
      regional = params[:order_user][:regional]
      comms = params[:order_user][:comms]
      art = params[:order_user][:art]
      processor = params[:order_user][:processor]
      designer = params[:order_user][:designer]
      client_contact = params[:order_user][:client_contact]
      arr_count = []
      i = 0

      if params[:order_user][:regional].present?
        arr_count.push(regional.length)
      else
        arr_count.push(0)
      end
      if params[:order_user][:comms].present?
        arr_count.push(comms.length)
      else
        arr_count.push(0)
      end
      if params[:order_user][:art].present?
        arr_count.push(art.length)
      else
        arr_count.push(0)
      end
      if params[:order_user][:processor].present?
        arr_count.push(processor.length)
      else
        arr_count.push(0)
      end
      if params[:order_user][:designer].present?
        arr_count.push(designer.length)
      else
        arr_count.push(0)
      end
      if params[:order_user][:client_contact].present?
        arr_count.push(client_contact.length)
      else
        arr_count.push(0)
      end

      while i < arr_count.max
        order_user = @order.order_users.new
        if params[:order_user][:regional].present?
          order_user.regional = regional[i]
        end
        if params[:order_user][:comms].present?
          order_user.comms = comms[i]
        end
        if params[:order_user][:art].present?
          order_user.art = art[i]
        end
        if params[:order_user][:processor].present?
          order_user.processor = processor[i]
        end
        if params[:order_user][:designer].present?
          order_user.designer = designer[i]
        end
        if params[:order_user][:client_contact].present?
          order_user.client_contact = client_contact[i]
        end
        if order_user.save
          flash[:notice] = "Order Users Successfully Updated"
        else
          flash[:error] = "Order Users Created Failed"
        end
        i = i + 1
      end
    end

    if order_user.errors.any?
      puts "******* ERRORS ********"
      order_user.errors.full_messages.each do |message|
        puts message
      end
    end

    redirect_to orders_path(:id => @order.id)
  end

  def create
    @order = Order.new
    @order.brand_id = params[:order][:brand_id]
    if params[:order][:brand_id] != "" || params[:order_entries].present? || params[:order_branch].present? || params[:order_user].present?
      if @order.save
        OrderHistory.create(:order_id => @order.id, :description => "has been Created", :user_id => current_user.id)
        if params[:order_entries].present?
          temp_order_entries = params[:order_entries].split(",").map { |s| s.to_i }
          temp_order_entries.each do |oe|
            order_entry = OrderEntry.new
            order_entry.order_id = @order.id
            product = Product.find(oe.to_i)
            order_entry.category_id = product.item_category_id
            order_entry.product_id = oe
            order_entry.specs = product.specs
            order_entry.notes = product.notes
            order_entry.vendor_quote_prices = product.vendor_quote_prices
            order_entry.dynamic_fields = product.dynamic_fields
            order_entry.quantity = product.per_carton
            order_entry.price = product.price_per_carton
            if order_entry.save
              order_entry_attachment = OrderEntryAttachment.where(:product_id => product.id).where('order_entry_id IS NULL')
              if order_entry_attachment.present?
                order_entry_attachment.each do |oea|
                  oea.update_attributes(:order_entry_id => order_entry.id)
                end
              end
              vendors = OrderEntryVendor.where(:product_id => oe)
              if vendors.present? && !vendors.nil?
                vendors.each do |vendor|
                  vendor.update_attributes(:order_entry_id => order_entry.id)
                end
              end
              OrderHistory.create(:order_id => order_entry.order_id, :order_entry_id => order_entry.id, :description => "has been Added", :user_id => current_user.id)
            end
          end
        end
        if params[:order_branch].present?
          temp_order_branch = params[:order_branch].split(",").map { |s| s.to_i }
          temp_order_branch.each do |ob|
            order_branch = OrderBranch.new
            order_branch.brand_id = @order.brand_id
            order_branch.order_id = @order.id
            order_branch.hotel_id = ob
            order_branch.save

          end
        end
        if params[:order_user].present?
          arr_count = []
          i = 0

          if params[:order_user][:regional].present?
            arr_count.push(params[:order_user][:regional].length)
          else
            arr_count.push(0)
          end
          if params[:order_user][:comms].present?
            arr_count.push(params[:order_user][:comms].length)
          else
            arr_count.push(0)
          end
          if params[:order_user][:art].present?
            arr_count.push(params[:order_user][:art].length)
          else
            arr_count.push(0)
          end
          if params[:order_user][:processor].present?
            arr_count.push(params[:order_user][:processor].length)
          else
            arr_count.push(0)
          end
          if params[:order_user][:designer].present?
            arr_count.push(params[:order_user][:designer].length)
          else
            arr_count.push(0)
          end
          if params[:order_user][:client_contact].present?
            arr_count.push(params[:order_user][:client_contact].length)
          else
            arr_count.push(0)
          end

          while i < arr_count.max
            order_user = OrderUser.new
            order_user.order_id = @order.id
            if params[:order_user][:regional].present?
              order_user.regional = params[:order_user][:regional][i]
            end
            if params[:order_user][:comms].present?
              order_user.comms = params[:order_user][:comms][i]
            end
            if params[:order_user][:art].present?
              order_user.art = params[:order_user][:art][i]
            end
            if params[:order_user][:processor].present?
              order_user.processor = params[:order_user][:processor][i]
            end
            if params[:order_user][:designer].present?
              order_user.designer = params[:order_user][:designer][i]
            end
            if params[:order_user][:client_contact].present?
              order_user.client_contact = params[:order_user][:client_contact][i]
            end
            order_user.save
            i = i + 1
          end
        end
        flash[:notice] = "Order Successfully Created"
      else
        flash[:error] = "Order Created Failed"
      end
    else
      flash[:error] = "All Empty Fields! Please Input ANY."
    end
    redirect_to orders_path(:id => @order.id)
  end

  def update_order
    temp_order = params[:order]
    @order = Order.find(temp_order[:id])

    # if @order.update_attributes(:brand_id => temp_order[:brand_id], :lead_time => temp_order[:lead_time], :status => temp_order[:status], :total_budget => temp_order[:total_budget])
    if @order.update_attributes(:brand_id => temp_order[:brand_id], :updated_at => Time.now)
    if params[:order_entries].present? || params[:existing_entries].present?
        order_entries = OrderEntry.where(:order_id => @order.id)
        order_entries.each do |oe|
          temp_existing_entries = params[:existing_entries].split(",").map { |s| s.to_i }

          if !temp_existing_entries.include? oe.id
            order_entry = OrderEntry.find(oe.id)
            if order_entry.destroy
              OrderEntryVendor.where(:order_entry_id => oe.id).destroy_all
              OrderEntryAttachment.where(:order_entry_id => oe.id).destroy_all
              OrderHistory.create(:order_id => order_entry.order_id, :product_id => order_entry.product_id, :description => "has been Removed", :user_id => current_user.id)
            end
          end
        end
        temp_order_entries = params[:order_entries].split(",").map { |s| s.to_i }
        temp_order_entries.each do |oe|
          order_entry = OrderEntry.new
          order_entry.order_id = @order.id
          product = Product.find(oe.to_i)
          order_entry.category_id = product.item_category_id
          order_entry.product_id = oe
          order_entry.specs = product.specs
          order_entry.notes = product.notes
          order_entry.vendor_quote_prices = product.vendor_quote_prices
          order_entry.dynamic_fields = product.dynamic_fields
          order_entry.quantity = product.per_carton
          order_entry.price = product.price_per_carton
          order_entry.save
          if order_entry.save
            order_entry_attachment = OrderEntryAttachment.where(:product_id => product.id).where('order_entry_id IS NULL')
            if order_entry_attachment.present?
              order_entry_attachment.each do |oea|
                oea.update_attributes(:order_entry_id => order_entry.id)
              end
            end
            vendors = OrderEntryVendor.where(:product_id => oe)
            if vendors.present? && !vendors.nil?
              vendors.each do |vendor|
                vendor.update_attributes(:order_entry_id => order_entry.id)
              end
            end
            OrderHistory.create(:order_id => order_entry.order_id, :order_entry_id => order_entry.id, :description => "has been Added", :user_id => current_user.id)
          end
        end
      end
      OrderBranch.where(:order_id => @order.id).destroy_all
      if params[:order_branch].present?
        temp_order_branch = params[:order_branch].split(",").map { |s| s.to_i }
        temp_order_branch.each do |ob|
          order_branch = OrderBranch.new
          order_branch.brand_id = @order.brand_id
          order_branch.order_id = @order.id
          order_branch.hotel_id = ob
          order_branch.save
        end
      end
      if params[:order_user].present?
        OrderUser.where(:order_id => @order.id).destroy_all
        arr_count = []
        i = 0

        if params[:order_user][:regional].present?
          arr_count.push(params[:order_user][:regional].length)
        else
          arr_count.push(0)
        end
        if params[:order_user][:comms].present?
          arr_count.push(params[:order_user][:comms].length)
        else
          arr_count.push(0)
        end
        if params[:order_user][:art].present?
          arr_count.push(params[:order_user][:art].length)
        else
          arr_count.push(0)
        end
        if params[:order_user][:processor].present?
          arr_count.push(params[:order_user][:processor].length)
        else
          arr_count.push(0)
        end
        if params[:order_user][:designer].present?
          arr_count.push(params[:order_user][:designer].length)
        else
          arr_count.push(0)
        end
        if params[:order_user][:client_contact].present?
          arr_count.push(params[:order_user][:client_contact].length)
        else
          arr_count.push(0)
        end

        while i < arr_count.max
          order_user = OrderUser.new
          order_user.order_id = @order.id
          if params[:order_user][:regional].present?
            order_user.regional = params[:order_user][:regional][i]
          end
          if params[:order_user][:comms].present?
            order_user.comms = params[:order_user][:comms][i]
          end
          if params[:order_user][:art].present?
            order_user.art = params[:order_user][:art][i]
          end
          if params[:order_user][:processor].present?
            order_user.processor = params[:order_user][:processor][i]
          end
          if params[:order_user][:designer].present?
            order_user.designer = params[:order_user][:designer][i]
          end
          if params[:order_user][:client_contact].present?
            order_user.client_contact = params[:order_user][:client_contact][i]
          end
          order_user.save
          i = i + 1
        end
      end
      flash[:notice] = "Order Successfully Updated"
    else
      flash[:error] = "Order Updated Failed"
    end
    redirect_to orders_path(:id => @order.id)
  end

  def edit
    @order = Order.find(params[:id])
  end

  def send_orders
    @order = Order.find(params[:order_id].to_i)
    @user = User.where(:email => "notifications@burningmidnight.com").first
    # @vendor_list = OrderEntry.where(:order_id => @order.id).select(:vendor).distinct
    @order_entry_list = OrderEntryVendor.where("order_entry_id IN (SELECT id FROM order_entries WHERE order_id = #{@order.id})")
    @vendor_list = @order_entry_list.select(:vendor_id).distinct
    if @vendor_list.length > 0
      @vendor_list.each do |vl|
        if !vl.vendor_id.nil? && vl.vendor_id != "null"
          @vendor = Vendor.find(vl.vendor_id)
          @order_entries = OrderEntry.where("order_id = #{@order.id} AND id IN (SELECT order_entry_id FROM order_entry_vendors WHERE vendor_id = #{vl.vendor_id})")
          if @vendor.email.present? && !@vendor.email.nil?
            OrderMailer.with(order: @order, vendor: @vendor, order_entries: @order_entries).send_order_entries.deliver_now
            flash[:notice] = "Order has sent successfully."
          else
            flash[:error] = "Vendor doesn't have an email!"
          end
        end
      end
    end
    redirect_to orders_path(@order)
  end

  def send_orders_to_vendors
    if params[:vendors].present? && params[:order_id].present?
      if params[:vendors].length > 0
        params[:vendors].each do |id|
          @vendor = Vendor.find(id.to_i)
          @order = Order.find(params[:order_id].to_i)
          @user = User.where(:email => "notifications@burningmidnight.com").first
          @order_entries = OrderEntry.where(:order_id => params[:order_id].to_i)
          if @vendor.email.present? && !@vendor.email.nil?
            OrderMailer.with(order: @order, vendor: @vendor, order_entries: @order_entries).send_order_entries.deliver_now
            flash[:notice] = "Order has sent successfully."
          else
            flash[:error] = "Vendor doesn't have an email!"
          end
        end
      end
    else
      flash[:error] = "No Vendor/s Selected"
    end
    redirect_to orders_path(:id => params[:order_id])
  end

  def load_messages
    respond_to do |format|
      @messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse
      @order = Order.find(@chatroom.id)

      format.js
    end
  end

  def load_item_messages
    if params[:order_entry_id].present?
      @order_entry = OrderEntry.find(params[:order_entry_id])
      respond_to do |format|
        @messages = ItemMessage.where(order_entry_id: @order_entry.id)
        @product = Product.find(@order_entry.product_id)
        @chatroom = ChatroomOrder.find(@order_entry.order_id)

        format.js
      end
    end
  end

  def item_details
    @product = Product.find(params[:id])
    render :layout => false
  end

  private

  def set_order
    if params[:id].present? && !params[:id].nil?
      @order = Order.find(params[:id])
    else
      @order = Order.last
    end
  end

  def set_chatroom
    if params[:chatroom_id].present?
      @chatroom = ChatroomOrder.find(params[:chatroom_id])
    end
  end

  def sort_column
    if params[:sort] != "brand"
      Order.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    else
      "brands.name"
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def set_search
    @search = OpenStruct.new(params[:search])
  end
end
