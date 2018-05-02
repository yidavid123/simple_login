class Spot < ApplicationRecord

  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  belongs_to :user

  # def full_street_address
  #    full_street_address = street_address + "," +
  #                          city + "," +
  #                          postal_code + "," +
  #                          country
  # end

end
