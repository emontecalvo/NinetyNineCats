require 'date'

class Cat < ActiveRecord::Base
  validates :name, presence:true
  validates :birth_date, presence: true
  validates :color, inclusion: { in: %w(black white orange tabby tortishell)}
  validates :sex, inclusion: { in: %w(M F) }

  has_many :cat_rental_requests, dependent: :destroy

  def age
    (Time.now.to_date - self.birth_date) / 365
  end
end
