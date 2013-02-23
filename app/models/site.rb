class Site < ActiveRecord::Base
  attr_accessible :base_url, :name
  has_many :visits
end
