class Prescription < ActiveRecord::Base
  belongs_to :consults
  has_attached_file :image
end
