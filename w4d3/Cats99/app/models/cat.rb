class Cat < ActiveRecord::Base
  COLORS = ["Red", "Black", "White", "Blue", "Other"]

  attr_accessible :birth_date, :color, :name, :sex

  validates :birth_date, :name, :sex, presence: true
  validates :color, presence: true, inclusion: { in: COLORS }
  before_validation :after_initialize

  def after_initialize
    self.age = (Date.today - self.birth_date) / 365.2564
  end
end
