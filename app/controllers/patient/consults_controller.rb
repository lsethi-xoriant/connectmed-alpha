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
    @opentok = OpenTok::OpenTok.new("45495952","42f917d02bfa970f99c4f7f53790e3b06a89e9eb")
    # role = :moderator #or :publisher
    #Store session ID in consults database when time to write code
    @tok_token = @opentok.generate_token @consult.sessionId #, {role: role}
  end

  def index
    @consults = current_patient.consults.order("created_at ASC")
  end

  def create
      @opentok = OpenTok::OpenTok.new("45495952","42f917d02bfa970f99c4f7f53790e3b06a89e9eb")
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
        if consult_params[:slot_id] == ""
          redirect_to patient_consult_path(@consult)
        else
          @slot = Slot.find(consult_params[:slot_id])
          @slot.update_attributes(:is_open => false)
          @consult.slot = @slot
          @patient = current_patient
          PatientMailer.scheduled_consult_confirmation(@consult,@slot,@patient).deliver
          redirect_to schedule_confirm_patient_consult_path(@consult)
        end
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

  def schedule_confirm
    @consult = Consult.find(params[:id])
    @slot = @consult.slot
  end

  private

    def consult_params
      params.require(:consult).permit(:date, :time, :purpose_descrip, :symptoms, :duration, :medications, :allergies, :slot_id)
    end
end
