class ContactsController < ApplicationController
  layout 'welcome'
  def new
    @contact = Contact.new
  end

  def create
    begin
      @contact = Contact.create!(params[:contact])
      @contact.request = request
      if @contact.deliver
        flash[:notice] = 'Thank you for your message. We will contact you soon!'
      else
        flash[:notice] = 'Cannot send message.'
      end
      redirect_to new_contact_path
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error_messages] = invalid.record.errors.full_messages
      flash[:notice] = 'Cannot send message.'
      redirect_to new_contact_path
    end
  end
end
