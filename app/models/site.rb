class Site < ActiveRecord::Base
  attr_accessible :base_url, :name
  has_many :visits

  # returns the hash {url: integer} of visit counts
  def calculate_visits
  	visits = Hash[]
 	  self.visits.each do |visit| 
   		if visits[visit.url].nil?
   			visits[visit.url] = 1
   		else
   			visits[visit.url] = visits[visit.url] + 1
   		end
   	end
   	return visits
  end

  # returns the hash {url: float} of avg visit durations
  def calculate_avg_duration
  	hash = Hash.new
   	self.visits.each do |visit| 
   		if hash[visit.url].nil?
   			hash[visit.url] = visit.duration
   		else
   			hash[visit.url] = hash[visit.url] + visit.duration
   		end
   	end
   	self.visits do |visit|
   		hash[visit.url] = hash[visit.url] / self.visits.where(:site_id => self.id).count
   	end
 	  return hash
  end
end
