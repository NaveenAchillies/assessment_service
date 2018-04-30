class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
    	t.references :exam
    	t.string :title
      t.timestamps
    end
  end
end
