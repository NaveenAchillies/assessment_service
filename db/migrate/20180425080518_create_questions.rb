class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
    	t.references :chapter
    	t.string :title
    	t.text :description
    	t.references :choice
    	t.integer :q_type
      t.timestamps
    end
  end
end
