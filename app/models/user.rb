class User < ApplicationRecord
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :lockable, :timeoutable
	has_many :answers


	def total_percent
		answers.select("if(status=#{Answer.statuses['correct']},count(id),0)/count(id) correct, if(status=#{Answer.statuses['wrong']},count(id),0)/count(id) wrong")[0]
	end
	
end
