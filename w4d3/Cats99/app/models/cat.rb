class Cat < ActiveRecord::Base
  COLORS = ["Red", "Black", "White", "Blue", "Other"]

  attr_accessible :birth_date, :color, :name, :sex

  validates :birth_date, :name, :sex, presence: true
  validates :color, presence: true, inclusion: { in: COLORS }
  before_validation :after_initialize

  has_many  :cat_rental_requests,
            class_name:  'CatRentalRequest',
            foreign_key: :cat_id,
            primary_key: :id

  def after_initialize
    p self.birth_date
    self.age = (Date.today - self.birth_date) / 365.2564
  end
end
