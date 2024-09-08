class CourseCompetency < ApplicationRecord
  self.table_name = 'competencies_courses'

  belongs_to :course
  belongs_to :competency
end
