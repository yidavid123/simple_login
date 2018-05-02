
class User < ApplicationRecord
  has_many :spots

  # extend Geocoder::Model::Mongoid
  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  has_many :spots

  def full_street_address
     full_street_address = street_address + "," +
                           city + "," +
                           postal_code + "," +
                           country
  end

end
