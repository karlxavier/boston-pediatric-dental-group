class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:edit, :update, :destroy, :show]

  def index
    @products = Product.product_wd_inventories
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def show
  end

  def update
    respond_to do |format|
        
        @product.audit_comment = "Updated product #{@product.id}-#{params[:name]}"

        if @product.update_attributes(product_params)
            format.html { redirect_to admin_products_path }
        else
            format.html { render 'edit' }
        end
    end
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
       if @product.save
            flash.now[:notice] = "File successfully created."
            format.html { redirect_to admin_products_path }
        else
            flash.now[:error] = "Error on creating new file."
            format.html { render 'new' }
        end
    end
  end

  def import_csv
      Product.import(params[:file])
      redirect_to admin_products_path
  end

  def destroy
      @products = Product.product_wd_inventories
      if @product.destroy
          flash.now[:notice] = "Product #{@product.name} successfully deleted."
      else
          flash.now[:error] = "Cannot delete this product, associations still exist."
      end
      render action: :index
  end

  private

    def product_params
      params.require(:product).permit(:name, :approval_status, :online_date, :offline_date, 
                                      :unit, :description, :base_product, :category, :price, 
                                      :variant_type, :style, :force_in_stock, :style_attribute_ids,
                                      :image, :cost, :active, :product_type_id, :sales_tax, :product_account_id,
                                      :product_cog_id, :product_asset_account_id, :depreciation,
                                      :purchase_description, :purchase_price, :specs,
                                      :hotel_id, :total_cost, :vendor_price, :full_value, :price_per_carton, :hotel_price, :per_carton, vendor_ids: [])
    end

    def set_product
      @product = Product.find(params[:id])
    end

end
