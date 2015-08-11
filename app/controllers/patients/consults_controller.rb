require 'opentok'

class Patients::ConsultsController < ApplicationController
  layout 'layout_2'
  before_filter :config_opentok,:except => [:index]

  def new
    # @consult = Consult.new
    # current_patient.consults << @consult
  end

  def show
    @consult = Consult.find(params[:id])
    @tok_token = @opentok.generate_token :session_id =>@consult.sessionId
  end

  def index
    @consults = Consult.where(:public => true).order(“created_at DESC”)
    @new_consult = Consult.new
  end

  def create
    session = @opentok.create_session(request.remote_addr)
    consult_params[:sessionId] = session.session_id
    @consult = Consult.new(consult_params)
    current_patient.consults << @consult
    if @consult.save
      redirect_to patients_consult_path(@consult)
    else
      redirect_to new_patients_consult_path
    end
  end

  private

    def config_opentok
      if @opentok.nil?
        @opentok = OpenTok::OpenTok.new(45307712,'a9bca2feffb7331786dbe53c02f28ef48ce92e98')
      end
    end

    def consult_params
      params.require(:consult).permit(:date, :time, :purpose_descrip, :duration, :medications, :allergies, :symptoms)
    end
end
