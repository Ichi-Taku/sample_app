FactoryBot.define do
  factory :relationship1, class: Relationship do
		#follower_id { User.first }
		#followed_id { User.last }
	end
	
	factory :relationship2, class: Relationship do
		#follower_id { User.find(2) }
		#followed_id { User.last }
	end
	
	factory :relationship3, class: Relationship do
		#follower_id { User.last }
		#followed_id { User.first }
  end
end