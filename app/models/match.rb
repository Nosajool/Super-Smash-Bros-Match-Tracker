class Match < ActiveRecord::Base
	belongs_to :winner, class_name: "User"
	belongs_to :loser, class_name: "User"

	default_scope -> { order('created_at DESC') }

	validates(:winner_id, presence: true)
	validates(:loser_id, presence: true)
	validates(:winner_stock, presence: true, inclusion: { in: 1..4 } )
end
