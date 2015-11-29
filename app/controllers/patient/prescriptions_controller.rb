class Patient::PrescriptionsController < ApplicationController
  layout 'patient_layout'
  skip_before_action :verify_authenticity_token
  before_filter :require_patient_signin

  def new
  end

  def show
    @consult = Consult.find(params[:consult_id])
    @prescription = Prescription.find(params[:id])
  end

  def index
  end

  def create
  end

  def edit
  end

  def download
    @prescription = Prescription.find(params[:id])
    img = Magick::Image.read(@prescription.image.path).first {format="png"}
    send_data img.to_blob,
              :filename => 'Prescription '+@prescription.name,
              :type => @prescription.image_content_type,
              :disposition => 'attachment'
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
