class Users::VendorsController < ApplicationController
  require 'csv'

  def import_csv
    Vendor.import(params[:file])
    redirect_to admin_vendors_path
  end

  def create
    @vendor = Vendor.new
    @vendor.name = params[:name]
    @vendor.email = params[:email]
    @vendor.billing_address = params[:address]
    @vendor.country_origin = params[:country]
    if @vendor.save
      if params[:category_id].present?
        params[:category_id].each do |id|
          VendorCategory.create(:vendor_id => @vendor.id, :category_id => id)
        end
      end
      flash[:notice] = "Vendor has saved successfully."
    else
      flash[:error] = "Vendor save Failed!"
    end
    redirect_to inventories_path
  end

  def new

  end

  def list

  end

  def add_item

  end

  def supplier

  end

  def items
    if params[:vendor_id].present?
      order_entry_vendors = OrderEntryVendor.where("vendor_id = '#{params[:vendor_id]}' AND order_entry_id IS NOT NULL").distinct(:order_entry_id)
      if !order_entry_vendors.nil? && order_entry_vendors.present?
        order_entry_ids = order_entry_vendors.pluck(:order_entry_id).map(&:inspect).join(',')
        puts "#{order_entry_ids.to_json}"
        if order_entry_ids != ''
          @order_entries = OrderEntry.where("id IN (#{order_entry_ids})")
        else
          @order_entries = nil
        end
      else
        @order_entries = nil
      end
    else
      @order_entries = nil
    end

    render :layout => false
  end

  def products
    @product = Product.where(:vendor_id => params[:id])
    render :layout => false
  end
end
