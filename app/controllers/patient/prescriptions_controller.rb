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
    localpath = @prescription.image.path
    if !localpath.nil?
      if @prescription.image_content_type == "application/pdf"    # not sure whether it is right way to check type
      send_file localpath,
              :filename => 'Prescription '+@prescription.name,
              :type => @prescription.image_content_type,
              :x_sendfile =>  true,
              :disposition => 'attachment'
      else

      img = Magick::Image.read(localpath).first {format="png"}
      send_data img.to_blob,
              :filename => 'Prescription '+@prescription.name,
              :type => @prescription.image_content_type,
              :disposition => 'attachment'
      end
    end
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
