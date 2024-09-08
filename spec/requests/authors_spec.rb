require 'swagger_helper'

RSpec.describe 'Authors API', type: :request do
  path '/authors' do
    get 'Retrieves all authors' do
      tags 'Authors'
      produces 'application/json'
      response '200', 'authors retrieved' do
        schema type: :array,
               items: { '$ref': '#/components/schemas/author' }

        run_test!
      end
    end

    post 'Creates an author' do
      tags 'Authors'
      consumes 'application/json'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: [ 'name' ]
      }

      response '201', 'author created' do
        schema '$ref': '#/components/schemas/author'

        let(:author) { { name: 'New Author' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:author) { { name: '' } }
        run_test!
      end
    end
  end

  path '/authors/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Retrieves an author' do
      tags 'Authors'
      produces 'application/json'
      response '200', 'author retrieved' do
        schema '$ref': '#/components/schemas/author'

        let(:id) { Author.create(name: 'Existing Author').id }
        run_test!
      end

      response '404', 'author not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Updates an author' do
      tags 'Authors'
      consumes 'application/json'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: [ 'name' ]
      }

      response '200', 'author updated' do
        schema '$ref': '#/components/schemas/author'

        let(:id) { Author.create(name: 'Existing Author').id }
        let(:author) { { name: 'Updated Author' } }
        run_test!
      end

      response '404', 'author not found' do
        let(:id) { 'invalid' }
        let(:author) { { name: 'Updated Author' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { Author.create(name: 'Existing Author').id }
        let(:author) { { name: '' } }
        run_test!
      end
    end

    delete 'Deletes an author' do
      tags 'Authors'
      response '204', 'author deleted' do
        let(:id) { Author.create(name: 'Existing Author').id }
        run_test!
      end

      response '404', 'author not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
