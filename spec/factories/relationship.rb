FactoryBot.define do
  factory :relationship1, class: Relationship do
		follower_id { 1 }
		followed_id { 3 }
	end
	
	factory :relationship2, class: Relationship do
		follower_id { 2 }
		followed_id { 3 }
	end
	
	factory :relationship3, class: Relationship do
		follower_id { 3 }
		followed_id { 1 }
  end
end