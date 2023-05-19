require "rails_helper"

RSpec.describe "Schools" do
  let(:user) { create(:user) }
  let(:resume) { create(:resume, user: user) }
  let(:school) { create(:school, resume: resume, name: "Blush") }
  let(:other_resume_school) { create(:school) }

  describe "GET #index" do
    context "when resume slug matches" do
      specify do
        get "/resumes/#{resume.slug}/schools"
        expect(response).to have_http_status(:success)
      end

      specify do
        school
        other_resume_school
        get "/resumes/#{resume.slug}/schools"
        expect(assigns(:schools)).to eq([school])
      end
    end

    context "when resume slug does not match" do
      specify do
        get "/resumes/#{resume.slug}1/schools"
        expect(flash[:alert]).to be_present
      end

      specify do
        get "/resumes/#{resume.slug}1/schools"
        expect(response).to redirect_to(resumes_path)
      end
    end
  end

  describe "GET #show" do
    context "when resume slug matches" do
      specify do
        get "/resumes/#{resume.slug}/schools/#{school.slug}"
        expect(response).to have_http_status(:success)
      end

      specify do
        get "/resumes/#{resume.slug}/schools/#{school.slug}"
        expect(assigns(:school)).to eq(school)
      end

      context "when the school slug does not match" do
        specify do
          get "/resumes/#{resume.slug}/schools/foo"
          expect(response).to redirect_to resumes_path
        end

        specify do
          get "/resumes/#{resume.slug}/schools/foo"
          expect(flash[:alert]).to eq "Educational experience not found."
        end
      end
    end
  end

  describe "GET #new" do
    context "when signed in as the owner" do
      before do
        login_as(user, scope: :user)
      end

      context "when resume slug matches" do
        specify do
          get "/resumes/#{resume.slug}/schools/new"
          expect(response).to have_http_status(:success)
        end

        specify do
          get "/resumes/#{resume.slug}/schools/new"
          expect(assigns(:school)).to be_a_new(School)
        end
      end
    end

    context "when signed in as a different user" do
      before do
        login_as(create(:user), scope: :user)
      end

      specify do
        expect {
          get "/resumes/#{resume.slug}/schools/new"
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "when not signed in" do
      specify do
        get "/resumes/#{resume.slug}/schools/new"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /create" do
    context "when signed in as the owner" do
      before do
        login_as(user, scope: :user)
      end

      specify do
        expect {
          post "/resumes/#{resume.slug}/schools", params: {school: {name: "WNYX"}}
        }.to change(School, :count).by(1)
      end

      specify do
        post "/resumes/#{resume.slug}/schools", params: {school: {name: "WNYX"}}
        expect(response).to redirect_to(resume_school_path(resume, School.last))
      end

      context "when the params are invalid" do
        specify do
          expect {
            post "/resumes/#{resume.slug}/schools", params: {school: {name: ""}}
          }.not_to change(School, :count)
        end
      end
    end
  end

  describe "GET /edit" do
    context "when signed in as the owner" do
      before do
        login_as(user, scope: :user)
      end

      specify do
        get "/resumes/#{resume.slug}/schools/#{school.slug}/edit"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /update" do
    context "when signed in as the owner" do
      before do
        login_as(user, scope: :user)
      end

      specify do
        patch "/resumes/#{resume.slug}/schools/#{school.slug}", params: {school: {name: "Blush Magazine"}}
        expect(response).to redirect_to(resume_school_path(resume_id: resume, id: "blush-magazine"))
      end

      context "when the params are invalid" do
        specify do
          patch "/resumes/#{resume.slug}/schools/#{school.slug}", params: {school: {name: ""}}
          expect(response).to render_template(:edit)
        end

        specify do
          patch "/resumes/#{resume.slug}/schools/#{school.slug}", params: {school: {name: ""}}
          expect(response).to have_http_status(:unprocessable_entity)
        end

        specify do
          patch "/resumes/#{resume.slug}/schools/#{school.slug}", params: {school: {name: ""}}
          expect(flash.now[:alert]).to eq "Educational experience not updated."
        end
      end
    end
  end

  describe "GET /destroy" do
    context "when signed in as the owner" do
      before do
        login_as(user, scope: :user)
      end

      specify do
        delete "/resumes/#{resume.slug}/schools/#{school.slug}"
        expect(response).to redirect_to(resume_schools_path(resume))
      end
    end
  end
end
