class AddressComponent
  include Mongoid::Document
  #field :long_name, type: String
  #field :short_name, type: String
  #field :types, type: String

  attr_reader :long_name, :short_name, :types

  def initialize(hash)
    @long_name = hash[:long_name]
    @short_name = hash[:short_name]
    @types = hash[:types]
  end

end
