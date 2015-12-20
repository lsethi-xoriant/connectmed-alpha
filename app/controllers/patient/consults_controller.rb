require 'opentok'

class Patient::ConsultsController < ApplicationController
  layout 'patient_layout'
  before_filter :require_patient_signin
  # before_filter :config_opentok,:except => [:index, :show]
  def new
    # @consult = Consult.new
    # current_patient.consults << @consult
  end

  def show
    @consult = Consult.find(params[:id])
    @consult.update_attributes(:patient_waiting => true)
    @opentok = OpenTok::OpenTok.new("45442022","12073bbd9ed790fa33022dcfdfa4bb207bed5969")
    # role = :moderator #or :publisher
    #Store session ID in consults database when time to write code
    @tok_token = @opentok.generate_token @consult.sessionId #, {role: role}
  end

  def index
    @consults = current_patient.consults.order("created_at ASC")
  end

  def create
    @opentok = OpenTok::OpenTok.new("45442022","12073bbd9ed790fa33022dcfdfa4bb207bed5969")
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

  def left
    @consult = Consult.find(params[:id])
    @consult.update_attributes(:patient_waiting => false)
    render :json => {:data => "success"}
  end

  def enter
    @consult = Consult.find(params[:id])
    @consult.update_attributes(:patient_waiting => true)
    render :json => {:data => "success"}
  end

  private

    def consult_params
      params.require(:consult).permit(:date, :time, :purpose_descrip, :symptoms, :duration, :medications, :allergies)
    end
end
