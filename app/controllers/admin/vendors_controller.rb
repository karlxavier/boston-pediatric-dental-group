class Admin::VendorsController < Admin::BaseController
    before_action :set_vendor, only: [:show, :edit, :update, :destroy]

    def index
        @vendors = Vendor.all
    end

    def show
        @vendors_product = VendorsProduct.new
        @vendor_category = VendorCategory.new
        @vendor_review = VendorReview.new
    end

    def new
        @vendor = Vendor.new
    end

    def create
        @vendor = Vendor.new(vendor_params)

        respond_to do |format|
           if @vendor.save
                format.html { redirect_to admin_vendors_path }
            else
                format.html { render 'new' }
            end
        end
    end

    def edit
    end

    def update
        respond_to do |format|
            if @vendor.update_attributes(vendor_params)
                format.html { redirect_to admin_vendors_path }
            else
                format.html { render 'edit' }
            end
        end
    end

    def destroy
        @vendors = Vendor.all
        if @vendor.destroy
            flash.now[:notice] = "Vendor #{@vendor.name} successfully deleted."
        else
            flash.now[:error] = "Cannot delete this vendor, associations still exist."
        end
        render action: :index
    end

    def import_csv
        Vendor.import(params[:file])
        redirect_to admin_vendors_path
    end

    private

        def vendor_params
            params.require(:vendor).permit(:name, :lead_time, :country_origin, :email, :billing_address,
                                            :company, :balance, :balance_total, :bill_from_1,
                                            :bill_from_2, :bill_from_3, :bill_from_4, :bill_from_5,
                                            :phone, :fax, :active)
        end

        def set_vendor
            @vendor = Vendor.find(params[:id])
        end

end
