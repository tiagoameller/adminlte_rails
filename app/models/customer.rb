# == Schema Information
#
# Table name: customers
#
#  id         :bigint(8)        not null, primary key
#  email      :string
#  name       :string
#  custid     :integer
#  dob        :date
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  active     :boolean          default(TRUE)
#

class Customer < ApplicationRecord
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :name, presence: true
  validates :custid, numericality: { only_integer: true, greater_than: 0 }
  validates :dob,
            date: { before: proc { Time.zone.now - 18.years } }
  validate :must_be_active

  private

  def must_be_active
    errors.add(:active, 'must be true') unless active
  end
end
