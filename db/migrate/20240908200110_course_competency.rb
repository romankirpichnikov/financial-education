class CourseCompetency < ActiveRecord::Migration[7.1]
  def change
    create_join_table :courses, :competencies, if_not_exists: true do |t|
      t.index :course_id
      t.index :competency_id
    end
  end
end
