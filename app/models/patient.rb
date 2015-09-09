class Patient < User
  has_many :consults
  has_many :doctors, through: :consults
  has_many :pharmacies, through: :consults

end
