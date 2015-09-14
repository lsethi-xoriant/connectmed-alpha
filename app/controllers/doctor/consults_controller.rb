class Doctor::ConsultsController < ApplicationController
  layout "doctor_layout"
  before_filter :require_doctor_signin

  def index
  end

  def create
  end

  def show
    @consult = Consult.find(params[:id])
    @consult.doctor = current_doctor
    @opentok = OpenTok::OpenTok.new("45334072","49403b241d18e0d4d3c4da37d89e3577d25a83e0")
    @tok_token = @opentok.generate_token @consult.sessionId
  end


end
