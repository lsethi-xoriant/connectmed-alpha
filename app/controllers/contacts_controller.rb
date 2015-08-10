class ContactsController < ApplicationController
  layout 'welcome'
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash[:notice] = 'Thank you for your message. We will contact you soon!'
    else
      flash[:error] = 'Cannot send message.'
    end
    redirect_to new_contact_path
  end
end
