class InventoriesController < ApplicationController
  def index
    @restock = Inventory.where("quantity < 10").count
    @no_stock = Inventory.where("quantity = 0 OR quantity is null").count
  end

  def add_item
    @brands = Brand.all
  end

  def create_item
    @product = Product.new
    @product.name = params[:product_name]
    @product.category = params[:category_id]
    @product.item_category_id = params[:item_category_id]
    @product.specs = params[:specs]
    @product.vendor_quote_prices = params[:vendor_quote_prices]
    @product.notes = params[:notes]
    @product.dynamic_fields = params[:dynamic_fields].to_s
    if @product.save
      inventory = Inventory.new
      inventory.product_id = @product.id
      inventory.quantity = params[:quantity]
      inventory.save
    end
    redirect_to view_stocks_inventories_path
  end

  def manage_by_hotel
    @brands = Brand.all
  end

  def view_stocks
    @categories = Category.all
    @inventories = Inventory.order('id DESC')
  end

  def show_brand
    @brand = Brand.find(params[:brand_id])
  end

  def restock
    if params[:inventory_id].present? && params[:quantity].present?
      inventory = Inventory.find(params[:inventory_id])
      quantity = (inventory.quantity.nil? ? 0 : inventory.quantity) + params[:quantity].to_i
      if inventory.update_attributes(:quantity => quantity)
        flash[:notice] = "Item has successfully restock"
      else
        flash[:error] = "Item Restock Failed. Invalid Quantity"
      end
    else
      flash[:error] = "Item Restock Failed. No Quantity Entered."
    end
    redirect_to view_stocks_inventories_path
  end

end
