class Country < ActiveRecord::Base
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	has_many :cities, dependent: :destroy
	has_many :people, dependent: :destroy
end
