class Answer < ApplicationRecord
	belongs_to :user
	belongs_to :question
	enum status: %i[skip correct wrong]

end
