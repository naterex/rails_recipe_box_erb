class Recipe < ActiveRecord::Base

  validates :title, :description, presence: true

  has_attached_file :image, styles: { medium: "400x400!>", thumb: "100x100>" }, default_url: "missing.png"
  # validates_with AttachmentPresenceValidator, attributes: :image
  validates_with AttachmentContentTypeValidator, attributes: :image, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes

  has_many :ingredients, dependent: :destroy
  has_many :directions, dependent: :destroy

  accepts_nested_attributes_for :ingredients,
                                reject_if: proc { |attributes| attributes['name'].blank? },
                                allow_destroy: true
  accepts_nested_attributes_for :directions,
                                reject_if: proc { |attributes| attributes['step'].blank? },
                                allow_destroy: true

end
