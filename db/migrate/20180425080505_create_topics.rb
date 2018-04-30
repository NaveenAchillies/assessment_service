class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
    	t.references :subject
    	t.string :title
      t.timestamps
    end
  end
end
