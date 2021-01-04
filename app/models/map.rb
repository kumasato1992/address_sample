class Map < ApplicationRecord
  after_validation :geocode

  private

  def geocode
    uri = URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address=" + self.address.gsub(" ", "") + "&key=AIzaSyCbVyr3cmdkQ3YPbWALgkj_hfCpg-7oZE4")
    res = HTTP.get(uri).to_s
    response = JSON.parse(res)
    binding.pry
    self.latitude = response["results"][0]["geometry"]["location"]["lat"]
    self.longitude = response["results"][0]["geometry"]["location"]["lng"]
  end
end
