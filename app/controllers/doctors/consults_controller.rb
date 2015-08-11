class Doctors::ConsultsController < ApplicationController
  before_filter :config_opentok,:except => [:index]
  def index
    @consults = Consult.where(:public => true).order(“created_at DESC”)
    @new_consult = Consult.new
  end

  def create
    session = @opentok.create_session request.remote_addr
    params[:consult][:sessionId] = session.session_id
    @new_consult = Consult.new(params[:consult])
    respond_to do |format|
      if @new_consult.save
      format.html { redirect_to(“/party/”+@new_consult.id.to_s) }
      else
      format.html { render :controller => ‘consults’,
      :action => “index” }
      end
    end
  end

  private

    def config_opentok
      if @opentok.nil?
      @opentok = OpenTok::OpenTokSDK.new 45307712, 'a9bca2feffb7331786dbe53c02f28ef48ce92e98'
    end

end
