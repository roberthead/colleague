require "rails_helper"

RSpec.describe "Employers" do
  let(:user) { create(:user) }
  let(:resume) { create(:resume, user: user) }
  let(:employer) { create(:employer, resume: resume, name: "Blush") }
  let(:other_resume_employer) { create(:employer) }

  describe "GET #index" do
    context "when resume slug matches" do
      specify do
        get "/resumes/#{resume.slug}/employers"
        expect(response).to have_http_status(:success)
      end

      specify do
        employer
        other_resume_employer
        get "/resumes/#{resume.slug}/employers"
        expect(assigns(:employers)).to eq([employer])
      end
    end

    context "when resume slug does not match" do
      specify do
        get "/resumes/#{resume.slug}1/employers"
        expect(flash[:alert]).to be_present
      end

      specify do
        get "/resumes/#{resume.slug}1/employers"
        expect(response).to redirect_to(resumes_path)
      end
    end
  end

  describe "GET #show" do
    context "when resume slug matches" do
      specify do
        get "/resumes/#{resume.slug}/employers/#{employer.slug}"
        expect(response).to have_http_status(:success)
      end

      specify do
        get "/resumes/#{resume.slug}/employers/#{employer.slug}"
        expect(assigns(:employer)).to eq(employer)
      end

      context "when the employer slug does not match" do
        specify do
          get "/resumes/#{resume.slug}/employers/foo"
          expect(response).to redirect_to resumes_path
        end

        specify do
          get "/resumes/#{resume.slug}/employers/foo"
          expect(flash[:alert]).to eq "Employer not found."
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
          get "/resumes/#{resume.slug}/employers/new"
          expect(response).to have_http_status(:success)
        end

        specify do
          get "/resumes/#{resume.slug}/employers/new"
          expect(assigns(:employer)).to be_a_new(Employer)
        end
      end
    end

    context "when signed in as a different user" do
      before do
        login_as(create(:user), scope: :user)
      end

      specify do
        expect {
          get "/resumes/#{resume.slug}/employers/new"
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "when not signed in" do
      specify do
        get "/resumes/#{resume.slug}/employers/new"
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
          post "/resumes/#{resume.slug}/employers", params: {employer: {name: "WNYX"}}
        }.to change(Employer, :count).by(1)
      end

      specify do
        post "/resumes/#{resume.slug}/employers", params: {employer: {name: "WNYX"}}
        expect(response).to redirect_to(resume_employer_path(resume, Employer.last))
      end

      context "when the params are invalid" do
        specify do
          expect {
            post "/resumes/#{resume.slug}/employers", params: {employer: {name: ""}}
          }.not_to change(Employer, :count)
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
        get "/resumes/#{resume.slug}/employers/#{employer.slug}/edit"
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
        patch "/resumes/#{resume.slug}/employers/#{employer.slug}", params: {employer: {name: "Blush Magazine"}}
        expect(response).to redirect_to(resume_employer_path(resume_id: resume, id: "blush-magazine"))
      end

      context "when the params are invalid" do
        specify do
          patch "/resumes/#{resume.slug}/employers/#{employer.slug}", params: {employer: {name: ""}}
          expect(response).to render_template(:edit)
        end

        specify do
          patch "/resumes/#{resume.slug}/employers/#{employer.slug}", params: {employer: {name: ""}}
          expect(response).to have_http_status(:unprocessable_entity)
        end

        specify do
          patch "/resumes/#{resume.slug}/employers/#{employer.slug}", params: {employer: {name: ""}}
          expect(flash.now[:alert]).to eq "Employer not updated."
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
        delete "/resumes/#{resume.slug}/employers/#{employer.slug}"
        expect(response).to redirect_to(resume_employers_path(resume))
      end
    end
  end
end
