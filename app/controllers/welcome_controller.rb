class WelcomeController < ApplicationController
  def index
  end

  def doctor_index
    render :layout => "doctor_welcome"
  end
end
