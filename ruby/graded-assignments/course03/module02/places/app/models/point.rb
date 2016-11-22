class Point
  include Mongoid::Document
  #field :longitude, type: String
  #field :latitude, type: String

  attr_accessor :longitude, :latitude

  def initialize(hash)
    if !hash[:coordinates].nil?
      @longitude = hash[:coordinates][0]
      @latitude = hash[:coordinates][1]
    else
      @longitude = hash[:lng]
      @latitude = hash[:lat]
    end
  end

  def to_hash
    {
      "type": "Point",
      "coordinates": [@longitude, @latitude]
    }
  end
end
