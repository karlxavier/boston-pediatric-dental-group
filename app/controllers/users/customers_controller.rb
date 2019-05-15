class Users::CustomersController < ApplicationController
  require 'csv'

  def import_csv
    Customer.import(params[:file])
    redirect_to admin_customers_path
  end
end
