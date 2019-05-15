class Users::DynamicMessagesController < ApplicationController
  respond_to :js, only: :show
  def show
    @order = Order.find(params[:id])
    @chatroom_order = ChatroomOrder.find(@order.id)
    @messages = @chatroom_order.messages.search(query: params[:search][:term]).order("#{sort_column} #{sort_direction}")
  end

  private 

  def sort_column
    Message.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end


  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end