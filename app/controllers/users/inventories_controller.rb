class Users::InventoriesController < ApplicationController

     def index
          respond_to do |format|
               if params[:filter].present?

                         if params[:filter][:inventory_status] === "low"
                              @inventories = Inventory.filter_status_low(params[:filter][:product_name].to_s)
                         elsif params[:filter][:inventory_status] === "sufficient"
                              @inventories = Inventory.filter_status_sufficient(params[:filter][:product_name].to_s)
                         else
                              @inventories = Inventory.filter_status_all(params[:filter][:product_name].to_s)
                         end

                    format.js
               else
                    @inventories = Inventory.all
                    format.html
               end
          end
     end

end