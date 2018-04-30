class CreateChapters < ActiveRecord::Migration[5.0]
  def change
    create_table :chapters do |t|
      t.references :topic
      t.string :name
      t.timestamps
    end
  end
end
