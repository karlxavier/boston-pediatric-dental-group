class Users::ChannelsController < ApplicationController
    before_action :set_channel, only: [:edit, :update, :show, :destory]

    def index
        if user_signed_in?
            if current_user.admin?
                @channels = Channel.order(created_at: :desc)
            else
                @channels = Channel.user_channels(current_user.id)
            end
        end
        @channel = @channels.first
    end

    def edit
        respond_to do |format|
            format.js
        end
    end

    def new
        respond_to do |format|
            format.js
        end
    end

    def create
        @channel = Channel.new(channel_params)

        respond_to do |format|
            if @channel.save
                @channels = Channel.all

                format.js
            else
                if @channel.errors.any?
                    puts '******* ERRORS ********'
                    @channel.errors.full_messages.each do |message|
                        puts message
                    end
                end
            end
        end
    end

    def update
        @channels = Channel.all
        respond_to do |format|
            if @channel.update_attributes(channel_params)
                format.js
            end
        end
    end

    def show
        respond_to do |format|
            format.js
        end
    end

    private

        def channel_params
            params.require(:channel).permit(:name, user_ids: [])
        end

        def set_channel
            @channel = Channel.find(params[:id])
        end
    

end
  