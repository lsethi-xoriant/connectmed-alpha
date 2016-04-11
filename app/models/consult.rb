class Consult < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor
  belongs_to :pharmacy
  has_one :slot
  has_many :prescriptions
end
