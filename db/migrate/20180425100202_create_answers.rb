class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
    	t.references :question
    	t.references :user
    	t.integer :status
    	t.string :option
      t.timestamps
    end
    add_index :answers, [:question_id,:user_id], :unique=>true
  end
end
