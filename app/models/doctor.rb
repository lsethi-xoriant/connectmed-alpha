class Doctor < User
  has_many :consults
  has_many :slots
  has_many :patients, through: :consults
  attr_accessor :directed_from
end
