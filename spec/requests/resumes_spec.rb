require "rails_helper"

RSpec.describe "Resumes" do
  let(:user) { create(:user) }

  describe "GET /resumes" do
    let(:user_resume) { create(:resume, user:) }
    let(:other_user_resume) { create(:resume) }

    before do
      user_resume
      other_user_resume
    end

    context "when signed in" do
      before do
        login_as(user, scope: :user)
      end

      specify do
        get "/resumes"
        expect(response).to have_http_status(:success)
      end

      specify do
        get "/resumes"
        expect(response).to render_template(:index)
      end

      specify do
        get "/resumes"
        expect(assigns(:resumes)).to match_array Resume.all
      end
    end

    context "when not signed in" do
      specify do
        get "/resumes"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /resume" do
    context "when signed in" do
      before do
        login_as(user, scope: :user)
      end

      context "when the user has a resume" do
        let!(:resume) { create(:resume, user: user) }

        specify do
          get "/resume"
          expect(response).to have_http_status(:success)
        end

        specify do
          get "/resume"
          expect(response).to render_template(:show)
        end

        specify do
          get "/resume"
          expect(assigns(:resume)).to eq resume
        end
      end

      context "when the user has no resume" do
        specify do
          get "/resume"
          expect(response).to redirect_to(new_resume_path)
        end
      end
    end

    context "when not signed in" do
      specify do
        get "/resume"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /resumes/:id" do
    context "when signed in" do
      before do
        login_as(user, scope: :user)
      end

      let!(:resume) { create(:resume) }

      specify do
        get "/resumes/#{resume.slug}"
        expect(response).to have_http_status(:success)
      end

      specify do
        get "/resumes/#{resume.slug}"
        expect(response).to render_template(:show)
      end

      specify do
        get "/resumes/#{resume.slug}"
        expect(assigns(:resume)).to eq resume
      end
    end
  end

  describe "GET /resumes/new" do
    context "when signed in" do
      before do
        login_as(user, scope: :user)
      end

      specify do
        get "/resumes/new"
        expect(response).to have_http_status(:success)
      end

      specify do
        get "/resumes/new"
        expect(response).to render_template(:new)
      end

      specify do
        get "/resumes/new"
        expect(assigns(:resume)).to be_a_new Resume
      end
    end

    context "when not signed in" do
      specify do
        get "/resumes/new"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST /resumes" do
    context "when signed in" do
      let(:params) do
        {
          resume: {
            field: "Web Development",
            profile: "I am a web developer that can help you build stuff"
          }
        }
      end

      before do
        login_as(user, scope: :user)
      end

      specify do
        post "/resumes", params: params
        expect(response).to redirect_to(assigns(:resume))
      end

      context "when save fails" do
        before do
          allow_any_instance_of(Resume).to receive(:save).and_return(false)
        end

        specify do
          post "/resumes", params: params
          expect(response).to render_template(:new)
        end

        specify do
          post "/resumes", params: params
          expect(response).to have_http_status(:unprocessable_entity)
        end

        specify do
          post "/resumes", params: params
          expect(flash.now[:alert]).to eq "Resume not created."
        end
      end
    end
  end

  describe "GET /resumes/:id/edit" do
    context "when signed in as the owner" do
      let(:resume) { create(:resume, user: user) }

      before do
        login_as(user, scope: :user)
      end

      specify do
        get "/resumes/#{resume.slug}/edit"
        expect(response).to have_http_status(:success)
      end

      specify do
        get "/resumes/#{resume.slug}/edit"
        expect(response).to render_template(:edit)
      end

      specify do
        get "/resumes/#{resume.slug}/edit"
        expect(assigns(:resume)).to eq resume
      end
    end

    context "when not signed in" do
      specify do
        get "/resumes/1/edit"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PATCH /resumes/:id" do
    context "when signed in as the owner" do
      let(:resume) { create(:resume, user: user) }
      let(:params) do
        {
          resume: {
            field: "Web Development",
            profile: "I am a web developer that can help you build stuff"
          }
        }
      end

      before do
        login_as(user, scope: :user)
      end

      specify do
        patch "/resumes/#{resume.slug}", params: params
        expect(response).to redirect_to(assigns(:resume))
      end

      context "when update fails" do
        before do
          allow_any_instance_of(Resume).to receive(:update).and_return(false)
        end

        specify do
          patch "/resumes/#{resume.slug}", params: params
          expect(response).to render_template(:edit)
        end

        specify do
          patch "/resumes/#{resume.slug}", params: params
          expect(response).to have_http_status(:unprocessable_entity)
        end

        specify do
          patch "/resumes/#{resume.slug}", params: params
          expect(flash.now[:alert]).to eq "Resume not updated."
        end
      end
    end

    context "when not signed in" do
      specify do
        patch "/resumes/1"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE /resumes/:id" do
    context "when signed in as the owner" do
      let(:resume) { create(:resume, user: user) }

      before do
        login_as(user, scope: :user)
      end

      specify do
        delete "/resumes/#{resume.slug}"
        expect(response).to redirect_to(resumes_path)
      end

      specify do
        delete "/resumes/#{resume.slug}"
        expect(flash[:notice]).to eq "Resume deleted."
      end

      context "when destroy fails" do
        before do
          allow_any_instance_of(Resume).to receive(:destroy).and_return(false)
        end

        specify do
          delete "/resumes/#{resume.slug}"
          expect(response).to render_template(:edit)
        end

        specify do
          delete "/resumes/#{resume.slug}"
          expect(flash.now[:alert]).to eq "Resume not deleted."
        end
      end
    end

    context "when not signed in" do
      specify do
        delete "/resumes/1"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
