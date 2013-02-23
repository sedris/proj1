class Visit < ActiveRecord::Base
  attr_accessible :duration, :url
  belongs_to :site
end
