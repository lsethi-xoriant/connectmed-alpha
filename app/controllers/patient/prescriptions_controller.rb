class Patient::PrescriptionsController < ApplicationController
  layout 'patient_layout'
  skip_before_action :verify_authenticity_token
  before_filter :require_patient_signin

  def new
  end

  def show
  end

  def index
  end

  def create
  end


  protected
    def json_request?
      request.format.json?
    end

  private
    def post_params
         params.require(:prescription).permit(:image, :name, :dosage, :notes)
    end
end
