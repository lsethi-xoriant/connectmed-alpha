class Prescription < ActiveRecord::Base
  belongs_to :consult
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"], styles: { medium: "300x300>", thumb: "100x100>" }

end
