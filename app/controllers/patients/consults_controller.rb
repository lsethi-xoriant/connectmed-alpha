require 'opentok'

class Patients::ConsultsController < ApplicationController
  layout 'layout_2'
  # before_filter :config_opentok,:except => [:index, :show]
  def new
    # @consult = Consult.new
    # current_patient.consults << @consult
  end

  def select_pharmacy
    @consult = Consult.find(params[:id])
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
    @consults = Consult.where(:public => true).order("created_at DESC")
    @new_consult = Consult.new
  end

  def create
    @opentok = OpenTok::OpenTok.new("45334072","49403b241d18e0d4d3c4da37d89e3577d25a83e0")
    session = @opentok.create_session :media_mode => :routed #(request.remote_addr)
    puts "Inside create"
    puts session.session_id
    temp_params = consult_params
    temp_params[:sessionId] = session.session_id
    @consult = Consult.new(temp_params)
    current_patient.consults << @consult
    if @consult.save
      redirect_to patients_consult_path(@consult)
    else
      redirect_to new_patients_consult_path
    end
  end


  private

    def consult_params
      params.require(:consult).permit(:date, :time, :purpose_descrip, :duration, :medications, :allergies, :symptoms)
    end
end
