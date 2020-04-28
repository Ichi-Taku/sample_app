FactoryBot.define do
  factory :post1, class: Micropost do
		association :user, factory: :user
		sequence(:content) { |n| "userの#{n}回目のpost" }
	end
	
	factory :post2, class: Micropost do
		association :user, factory: :other_user
		sequence(:content) { |n| "other_userの#{n}回目のpost" }
	end
	
	factory :post3, class: Micropost do
		association :user, factory: :taro
		sequence(:content) { |n| "taroの#{n}回目のpost" }
  end
end