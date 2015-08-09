class Consult < ActiveRecord::Base
  belongs_to :patient
  belogns_to :doctor
end
