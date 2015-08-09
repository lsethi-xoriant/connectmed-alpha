class Doctor < User
  has_many :consults
  has_many :patients, through :consults
end
