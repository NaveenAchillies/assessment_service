class Question < ApplicationRecord
	belongs_to :chapter
	has_many :choices
	belongs_to :correct_choice, :class_name => 'Choice', foreign_key: "choice_id", optional: true
	has_many :answers
	enum q_type: %i[easy medium hard]
end
