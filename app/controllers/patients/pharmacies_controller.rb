class Patients::PharmaciesController < ApplicationController
  layout 'layout_2'
  skip_before_action :verify_authenticity_token


  def new
  end

  def show
  end

  def index
  end

  def create
    puts "inside create"
    puts params
    # puts params_hash
    # @pharmacy = Consult.new(temp_params)
    redirect_to '/'
  end


  protected

  def json_request?
    request.format.json?
  end

end
