class Patient < User
  has_many :consults
  has_many :doctors, through: :consultsin

end
