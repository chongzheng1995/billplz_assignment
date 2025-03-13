class Bank < ApplicationRecord
  # Bank.create!(code: "cimb1", bank_type: "cimb", isFpx: true, isObw: false, active: true)
  # Bank.create!(code: "cimb2", bank_type: "cimb", isFpx: false, isObw: true, active: true)
  # Bank.create!(code: "mbb1", bank_type: "maybank", isFpx: false, isObw: true, active: true)
  # Bank.create!(code: "mbb2", bank_type: "maybank", isFpx: false, isObw: true, active: false)
  # Bank.create!(code: "pbb1", bank_type: "public bank", isFpx: true, isObw: false, active: false)

  scope :default_listing, ->(bank_type = nil) {
    query = where(active: true).order(isObw: :desc)
    query = query.where(bank_type: bank_type) if bank_type.present?
    query
  }

  def self.bank_types
    pluck(:bank_type).uniq.compact
  end
end
