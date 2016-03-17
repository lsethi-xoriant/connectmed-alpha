class LandingsController < ApplicationController

  def index
    @patient = Patient.new
  end

  def demo_index
    @patient = Patient.new
  end

  def doctor_index
    @doctor = Doctor.new
  end

  def how_it_works
  end

  def about_us
  end

  def overview
  end

  def melissa
    render :layout => "empty"
  end

end
