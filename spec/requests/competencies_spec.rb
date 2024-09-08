require 'swagger_helper'

RSpec.describe 'Competencies API', type: :request do
  path '/competencies' do
    get 'Retrieves all competencies' do
      tags 'Competencies'
      produces 'application/json'
      response '200', 'competencies found' do
        schema type: :array, items: { '$ref' => '#/components/schemas/Competency' }

        let!(:competencies) { create_list(:competency, 3) }

        run_test!
      end
    end

    post 'Creates a competency' do
      tags 'Competencies'
      consumes 'application/json'
      parameter name: :competency, in: :body, schema: { '$ref' => '#/components/schemas/Competency' }

      response '201', 'competency created' do
        let(:competency) { { name: 'New Competency' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:competency) { { name: nil } }
        run_test!
      end
    end
  end

  path '/competencies/{id}' do
    get 'Retrieves a competency' do
      tags 'Competencies'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'competency found' do
        schema '$ref' => '#/components/schemas/Competency'

        let(:competency) { create(:competency) }
        let(:id) { competency.id }

        run_test!
      end

      response '404', 'competency not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Updates a competency' do
      tags 'Competencies'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :competency, in: :body, schema: { '$ref' => '#/components/schemas/Competency' }

      response '200', 'competency updated' do
        schema '$ref' => '#/components/schemas/Competency'

        let(:competency) { create(:competency) }
        let(:id) { competency.id }
        let(:competency_params) { { name: 'Updated Name' } }

        run_test!
      end
    end

    delete 'Deletes a competency' do
      tags 'Competencies'
      parameter name: :id, in: :path, type: :integer

      response '204', 'competency deleted' do
        let!(:competency) { create(:competency) }
        let(:id) { competency.id }

        run_test!
      end

      response '404', 'competency not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
