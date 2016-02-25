class Prescription < ActiveRecord::Base
  belongs_to :consult
  has_attached_file :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif","application/pdf", "application/msword"]

end
