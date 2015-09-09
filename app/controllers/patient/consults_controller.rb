require 'opentok'

class Patient::ConsultsController < ApplicationController
  layout 'layout_2'
  before_filter :require_patient_signin
  # before_filter :config_opentok,:except => [:index, :show]
  def new
    # @consult = Consult.new
    # current_patient.consults << @consult
  end

  def show
    @consult = Consult.find(params[:id])
    @opentok = OpenTok::OpenTok.new("45334072","49403b241d18e0d4d3c4da37d89e3577d25a83e0")
    puts "Inside Show"
    puts @consult.sessionId
    # role = :moderator #or :publisher
    #Store session ID in consults database when time to write code
    @tok_token = @opentok.generate_token @consult.sessionId #, {role: role}
  end

  def index
    @consults = current_patient.consults.order("created_at DESC")
  end

  def create
    @opentok = OpenTok::OpenTok.new("45334072","49403b241d18e0d4d3c4da37d89e3577d25a83e0")
    begin
      session = @opentok.create_session :archive_mode => :always, :media_mode => :routed
    rescue
      session = @opentok.create_session
    end
    temp_params = consult_params
    temp_params[:sessionId] = session.session_id
    @consult = Consult.new(temp_params)
    current_patient.consults << @consult
    if @consult.save
      redirect_to patient_consult_path(@consult)
    else
      redirect_to patient_new_consult_path
    end
  end


  private

    def consult_params
      params.require(:consult).permit(:date, :time, :purpose_descrip, :duration, :medications, :allergies, :symptoms)
    end
end
