require 'swagger_helper'

RSpec.describe 'Courses API', type: :request do
  path '/courses' do
    get 'Retrieves all courses' do
      tags 'Courses'
      produces 'application/json'
      response '200', 'courses found' do
        schema type: :array, items: { '$ref' => '#/components/schemas/course' }

        before do
          create_list(:course, 3)
        end

        run_test!
      end
    end

    post 'Creates a course' do
      tags 'Courses'
      consumes 'application/json'
      parameter name: :course, in: :body, schema: { '$ref' => '#/components/schemas/course' }
      response '201', 'course created' do
        let(:author) { create(:author) } # Ensure an author is created
        let(:course) { { title: 'New Course', description: 'New Description', author_id: author.id } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:course) { { title: 'Invalid Course', description: 'Missing author' } }
        run_test!
      end
    end
  end

  path '/courses/{id}' do
    get 'Retrieves a course' do
      tags 'Courses'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer
      response '200', 'course found' do
        schema '$ref' => '#/components/schemas/course'

        let(:id) { create(:course).id }
        run_test!
      end
    end

    patch 'Updates a course' do
      tags 'Courses'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          author_id: { type: :integer }
        }
      }
      response '200', 'course updated' do
        let(:id) { create(:course).id }
        let(:course) { { title: 'Updated Course Title' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { create(:course).id }
        let(:course) { { title: '' } }
        run_test!
      end
    end

    delete 'Deletes a course' do
      tags 'Courses'
      parameter name: :id, in: :path, type: :integer
      response '204', 'course deleted' do
        let(:id) { create(:course).id }
        run_test!
      end
    end
  end
end
