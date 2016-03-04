class Slot < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :consult

end
