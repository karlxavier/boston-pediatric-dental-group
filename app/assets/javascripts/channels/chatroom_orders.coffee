App.chatroom_orders = App.cable.subscriptions.create "ChatroomOrdersChannel",
  connected: ->
    console.log 'chika-minute!'

  disconnected: ->
    console.log 'chatroom disconnected'

  received: (data) ->
    console.log 'message received'
    $("#new_message")[0].reset()
    active_chatroom = $("[data-behavior='chatroom-orders'][data-chatroom-id='#{data.channel_id}']")
    chatbox = $("[data-behavior='chatbox'][data-chatroom-id='#{data.channel_id}']")
    notification_count = $("#notification-count").html()
    browser_id = $("#browser_id").val()

    if data.message_user_id.toString() != browser_id.toString()
      $("#notification-count").css("display", "")
      if notification_count.length > 0
        count = parseInt( notification_count, 10 ) + 1
        $("#notification-count").html(count)

    if active_chatroom.length > 0
      active_chatroom.append(data.message)

      chat_messages = $("#chatroom_msgs")[0]
      if chat_messages
        height = chat_messages.scrollHeight
        # $(chat_messages).scrollTop(height)
        $(chat_messages).animate({ scrollTop: $(chat_messages).prop("scrollHeight")}, 1000)
    else if chatbox.length > 0
      chatbox.append(data.message)

      chat_messages = $("#chatroom_msgs")[0]
      if chat_messages
        height = chat_messages.scrollHeight
        # $(chat_messages).scrollTop(height)
        $(chat_messages).animate({ scrollTop: $(chat_messages).prop("scrollHeight")}, 1000)
    # else
    #     toastr.options =
    #     closeButton: true
    #     progressBar: true
    #     onclick: ->
    #       window.location.replace "/chatroom_orders/#{data.channel_id}/messages/#{data.channel_id}"
    #       return
    #     showMethod: 'slideDown'
    #     positionClass: 'toast-bottom-left'
    #     timeOut: 7000
    #     toastr.warning data.username + ' sent a message in ' + data.chatroom_name , 'New Message'

