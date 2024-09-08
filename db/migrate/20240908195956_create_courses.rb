class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses, if_not_exists: true do |t|
      t.string :title
      t.text :description
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
