class Pharmacy < ActiveRecord::Base
  has_many :patients
end
