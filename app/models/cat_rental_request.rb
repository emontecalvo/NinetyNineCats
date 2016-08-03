require 'date'

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED)}

  validate :overlapping_approved_requests

  belongs_to :cat

  def overlapping_requests
    cat.cat_rental_requests.select do |crr|
      self.start_date.between?(crr.start_date, crr.end_date) || self.end_date.between?(crr.start_date, crr.end_date)
    end
  end

  def overlapping_approved_requests
    overlap_check = overlapping_requests.none? do |overlapping_request|
      overlapping_request.status == "APPROVED"
    end
    if overlap_check == false
      errors[:overlapping] << "Request overlaps with another approved request"
    else
      return true
    end
  end
end
