class AuthorDeletionService
  def initialize(author_id)
    @author = Author.find(author_id)
  end

  def call
    ActiveRecord::Base.transaction do
      assign_random_author_to_courses
      author.destroy!
    end
  rescue ActiveRecord::RecordInvalid => e
    false
  end

  private

  attr_reader :author

  def assign_random_author_to_courses
    other_authors = Author.where.not(id: author.id).limit(10)
    return if other_authors.empty?

    random_author = other_authors.sample
    author.courses.update_all(author_id: random_author.id)
  end
end
