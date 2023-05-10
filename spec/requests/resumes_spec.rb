require "rails_helper"

RSpec.describe "Resumes" do
  let(:user) { create(:user) }

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
        get "/resumes/#{resume.id}"
        expect(response).to have_http_status(:success)
      end

      specify do
        get "/resumes/#{resume.id}"
        expect(response).to render_template(:show)
      end

      specify do
        get "/resumes/#{resume.id}"
        expect(assigns(:resume)).to eq resume
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
          expect(flash.now[:alert]).to eq "Resume not created"
        end
      end
    end
  end
end
