class Users::DynamicItemMessagesController < ApplicationController
  respond_to :js, only: :show
  def show
    @order_entry = OrderEntry.find(params[:id])
    @chatroom = ChatroomOrder.find(@order_entry.order_id)
    @product = Product.find(@order_entry.product_id)
    @messages = ItemMessage.search(query: params[:search][:term], order_entry_id: @order_entry.id).order("#{sort_column} #{sort_direction}")
  end

  private 

  def sort_column
    ItemMessage.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end