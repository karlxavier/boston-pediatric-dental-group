class Users::FilterNotificationsController < ApplicationController
  respond_to :js, only: :show
  def show
    @order_histories = OrderHistory.search(query: params[:search][:term], order_id: params[:id]).order("#{sort_column} #{sort_direction}")
  end

  private 

  def sort_column
    OrderHistory.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end