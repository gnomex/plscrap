require 'rails_helper'

Rails.application.routes.default_url_options[:host] = 'localhost:3000'

RSpec.describe "/projects", type: :request do
  describe "GET /index" do
    context 'without data' do
      let(:expected) {
        {
          total_items: 0,
          page: 1,
          total_pages: 0,
          items_per_page: 10,
          prev_page: nil,
          next_page: nil,
          projects: []
        }.with_indifferent_access
      }

      it "renders a successful response with no data" do
        get projects_url

        expect(response).to be_successful
        expect(JSON.parse(response.body)).to eq(expected)
      end
    end

    context 'with one page data' do
      let(:projects) {
        [
          { name: "1", link: "uri", description: "PL 1/00" },
          { name: "2", link: "uri", description: "PL 2/00" },
          { name: "3", link: "uri", description: "PL 3/00" }
        ]
      }
      let(:expected) {
        {
          total_items: 3,
          page: 1,
          total_pages: 1,
          items_per_page: 10,
          prev_page: nil,
          next_page: nil,
          projects: projects
        }.with_indifferent_access
      }

      before do
        allow(LawProject).to receive(:page) do
          Kaminari.paginate_array(projects).page(1)
        end
      end

      it "renders a successful response with paginated data" do
        get projects_url

        result = JSON.parse(response.body)

        expect(response).to be_successful
        expect(result["projects"]).to_not be_empty
        expect(result).to eq(expected)
      end
    end

    context 'with two page data' do
      let(:projects) {
        [
          { name: "1", link: "uri", description: "PL 1/00" },
          { name: "2", link: "uri", description: "PL 2/00" },
          { name: "3", link: "uri", description: "PL 3/00" },
          { name: "4", link: "uri", description: "PL 4/00" },
          { name: "5", link: "uri", description: "PL 5/00" },
          { name: "6", link: "uri", description: "PL 6/00" },
          { name: "7", link: "uri", description: "PL 7/00" },
          { name: "8", link: "uri", description: "PL 8/00" },
          { name: "9", link: "uri", description: "PL 9/00" },
          { name: "10", link: "uri", description: "PL 10/00" },
          { name: "11", link: "uri", description: "PL 11/00" }
        ]
      }
      let(:expected) {
        {
          total_items: 11,
          page: 2,
          total_pages: 2,
          items_per_page: 10,
          prev_page: "http://localhost:3000/projects?page=1",
          next_page: nil,
          projects: [
            { name: "11", link: "uri", description: "PL 11/00" }
          ]
        }.with_indifferent_access
      }

      before do
        allow(LawProject).to receive(:page) do
          Kaminari.paginate_array(projects).page(2)
        end
      end

      it "renders a successful response for last paginated data" do
        get (projects_url + "?page=2")

        result = JSON.parse(response.body)

        expect(response).to be_successful
        expect(result["projects"]).to_not be_empty
        expect(result["projects"].size).to eq(1)
        expect(result).to eq(expected)
      end
    end
  end
end
