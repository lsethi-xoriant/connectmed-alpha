class Patient::SlotsController < ApplicationController
  layout "patient_layout"
  before_filter :require_patient_signin

  def index
    render json: Slot.all
  end

  def index_open
    render json: Slot.where(is_open: true)
  end

  def index_taken
    render json: Slot.where(is_open: false)
  end

  def schedule
    @consult = Consult.new
    @count = 0;
    @time = Time.new(2002, 10, 30, 11, 0);
    @dates = [Date.today,Date.today+1,Date.today+2,Date.today+3]
    arr1 = Slot.where(hour: 11,minute: 0,is_open:true).order("date")
    arr2 = Slot.where(hour: 11,minute: 30,is_open:true).order("date")
    arr3 = Slot.where(hour: 12,minute: 0,is_open:true).order("date")
    arr4 = Slot.where(hour: 12,minute: 30,is_open:true).order("date")
    arr5 = Slot.where(hour: 13,minute: 0,is_open:true).order("date")
    arr6 = Slot.where(hour: 13,minute: 30,is_open:true).order("date")
    arr7 = Slot.where(hour: 14,minute: 0,is_open:true).order("date")
    arr8 = Slot.where(hour: 14,minute: 30,is_open:true).order("date")
    @slots_arrays = [arr1,arr2,arr3,arr4,arr5,arr6,arr7,arr8]
  end

end
