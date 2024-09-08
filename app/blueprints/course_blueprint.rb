class CourseBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :description, :author_id

  association :author, blueprint: AuthorBlueprint
end
