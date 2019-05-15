class Users::EmailTemplatesController < ApplicationController
  def create
    parse_template = params[:email_template]

    @email_template = EmailTemplate.new
    @email_template.order_id = parse_template[:order_id]
    @email_template.user_id = current_user.id
    @email_template.content = parse_template[:content]

    if @email_template.save
      # Email Template Users
      # Order User or Additional Emails:
      if parse_template[:cc].present?
        parse_template[:cc].split(',').each do |email|
          EmailTemplateUser.create(:email_template_id => @email_template.id, :email => email, :user_type => "cc")
        end
      end
      # Vendors or Additional Emails:
      if parse_template[:to].present?
        parse_template[:to].split(',').each do |email|
          EmailTemplateUser.create(:email_template_id => @email_template.id, :email => email, :user_type => "to")
        end
      end

      # Sender:
      if parse_template[:sender].present?
        EmailTemplateUser.create(:email_template_id => @email_template.id, :email => parse_template[:sender], :user_type => "sender")
      else
        EmailTemplateUser.create(:email_template_id => @email_template.id, :email => current_user.email, :user_type => "sender")
      end

      #Email Template Order Entry (Items)
      # Order Entries:
      if parse_template[:order_entry_ids].present?
        parse_template[:order_entry_ids].split(',').each do |id|

          @order_entry = OrderEntry.find(id)

          EmailTemplateOrderEntry.create(:email_template_id => @email_template.id, :order_entry_id => id.to_i)
        end
      end

      #Email Template Attachment
      # Attachments:
      if params[:file].present?
        params[:file].each do |attachment_file|
          email_template_attachment = EmailTemplateAttachment.new
          email_template_attachment.email_template_id = @email_template.id
          email_template_attachment.attachment_file = params[:file]["#{attachment_file}"]
          email_template_attachment.save
        end
      end
      if parse_template[:order_entry_ids].present?
        attachment_list = OrderEntryAttachment.where("order_entry_id IN (#{parse_template[:order_entry_ids]})")
        if parse_template[:removed_attachments].present? && parse_template[:removed_attachments] != ''
          attachment_list = attachment_list.where("id NOT IN (#{parse_template[:removed_attachments]})")
        end
        if attachment_list.length > 0
          attachment_list.each do |attachment|
            email_template_attachment = EmailTemplateAttachment.new
            email_template_attachment.email_template_id = @email_template.id
            email_template_attachment.attachment_file = attachment.attachment_file
            email_template_attachment.save
          end
        end
      end

      EmailTemplateUser.where(:email_template_id => @email_template.id, :user_type => "to").pluck(:email).each do |email|
        OrderMailer.send_request_quote(@email_template, email).deliver_now
      end
      if parse_template[:btn_type] == 'create_order'
        flash[:notice] = "Create Order Successfully Sent."
      else
        flash[:notice] = "Request Quote Successfully Sent."
      end

    else
      if parse_template[:btn_type] == 'create_order'
        flash[:notice] = "Create Order Sent Failure!"
      else
        flash[:error] = "Request Quote Sent Failure!"
      end
    end
    @order = Order.find(parse_template[:order_id])
    redirect_to orders_path(@order)
  end
end