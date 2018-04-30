class User < ApplicationRecord
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :lockable, :timeoutable
	has_many :answers

	def total_percent
		answers.select("count(if(status=#{Answer.statuses['correct']},id,null))/count(id) correct, count(if(status=#{Answer.statuses['wrong']},id,null))/count(id) wrong")[0]
	end	
end
