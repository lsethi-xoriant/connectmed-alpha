class Doctor::ConsultsController < ApplicationController
  layout "doctor_layout"
  before_filter :require_doctor_signin

  def index
    @consults = current_doctor.consults.order("created_at ASC")
  end

  def create
  end

  def edit
    @consult = Consult.find(params[:id])
    @prescription = @consult.prescriptions.first
  end

  def update
    @consult = Consult.find(params[:id])
    if @consult.prescriptions.empty? # Record internal notes from during call (before after call report)
      @consult.update(consult_params)
      redirect_to new_doctor_consult_prescription_path(@consult)
    else # Update call report
      @prescription = @consult.prescriptions.first
      if @prescription.update(prescription_params) && @consult.update(consult_params)
        redirect_to edit_doctor_consult_path(@consult)
        flash[:success_messages] = "The Consult Record Has been Updated"
      else
        begin
        @prescription.update!(prescription_params)
        @consult.update!(consult_params)
        rescue ActiveRecord::RecordInvalid => invalid
          flash[:error_messages] = invalid.record.errors.full_messages
          redirect_to edit_doctor_consult_path(@consult)
        end
      end
    end
  end

  def show
    @consult = Consult.find(params[:id])
    current_doctor.consults << @consult
    @opentok = OpenTok::OpenTok.new("45334072","49403b241d18e0d4d3c4da37d89e3577d25a83e0")
    @tok_token = @opentok.generate_token @consult.sessionId
  end

  private
    def consult_params
      params.require(:consult).permit(:internal_notes,:treatment_result,:treatment_descrip)
    end

    def prescription_params
      params.require(:prescription).permit(:notes, :result, :name, :dosage)
    end

end
