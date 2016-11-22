class Profile < ActiveRecord::Base
  belongs_to :user

  #validates :first_name, presence: true
  #validates :last_name, presence: true
  #validates :first_name, allow_nil: true
  #validates :last_name, allow_nil: true
  
  validate :first_xor_last

  def first_xor_last
    if (first_name.nil? and last_name.nil?)
      errors.add(:base, "Specify atleast first_name or last_name.")
    end
  end

  validates :gender,
  	:inclusion => { :in => ['male', 'female'], 
  	:message => "%{value} is not a valid gender" }

  validate :first_name_sue

  def first_name_sue
  	if first_name == "Sue" and gender == "male"
  	  errors.add(:base, "first_name: Sue is NOT allowed for gender: male")
  	end
  end 

  # class method
  def self.get_all_profiles(min, max)
  	Profile.where(:birth_year => min..max).order(:birth_year)
  end
end
