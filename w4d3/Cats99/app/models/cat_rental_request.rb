class CatRentalRequest < ActiveRecord::Base
  attr_accessible :cat_id, :begin_date, :end_date, :status

  validates :cat_id, :begin_date, :end_date, presence: true
  validate :no_overlapping_rental_dates, :dates_in_correct_order

  belongs_to  :cat,
              class_name:  'Cat',
              foreign_key: :cat_id,
              primary_key: :id

  def dates_in_correct_order
    if self.begin_date > self.end_date
      errors[:rental_dates] << "must begin before they end"
    end
  end

  def no_overlapping_rental_dates
    return unless changing_status_to_approved?
    requests = CatRentalRequest.find_by_cat_id_and_status(self.cat_id, 'approved')

    requests.each do |request|
      unless  self.begin_date < request.begin_date &&
              self.end_date   < request.begin_date
        errors[:rental_dates] << "can't overlap others' approved rental dates"
        return
      end

      unless  self.begin_date > request.end_date &&
              self.end_date   > request.end_date
        errors[:rental_dates] << "can't overlap others' approved rental dates"
        return
      end
    end
  end

  def changing_status_to_approved?
    return false unless self.status == 'approved'
    return true if self.id.nil?
    return true if CatRentalRequest.find(self.id).empty?

    old_request = CatRentalRequest.find(self.id)
    return false if old_request.status == 'approved'

    true
  end
end
