require 'rails_helper'

describe Admin::UploadsController do
  before { set_admin_user }

  describe 'GET new' do
    it_behaves_like 'require admin' do
      let(:action) { get :new }
    end

    it 'assigns @upload' do
      get :new
      expect(assigns(:upload)).to be_instance_of Upload
      expect(assigns(:upload)).to be_new_record
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    it_behaves_like 'require admin' do
      let(:action) { get :new }
    end

    context 'with valid params' do
      let(:valid_params) { Fabricate.attributes_for(:upload) }

      it 'saves a new upload' do
        post :create, upload: valid_params
        expect(Upload.first.media_file_name).to eq('placeholder3d15e3a5eaae04842667502103f994d8.gif')
      end

      it 'assigns flash success message' do
        post :create, upload: valid_params
        expect(flash[:success]).to be_present
      end

      it 'redirects to new admin uploads path' do
        post :create, upload: valid_params
        expect(response).to redirect_to new_admin_upload_path
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { Fabricate.attributes_for(:upload, media: nil) }

      it 'does not save a new upload' do
        post :create, upload: invalid_params
        expect(Upload.all.size).to eq(0)
      end

      it 'assigns @upload' do
        post :create, upload: invalid_params
        expect(assigns(:upload)).to be_instance_of Upload
      end

      it 'assigns flash danger message' do
        post :create, upload: invalid_params
        expect(flash.now[:danger]).to be_present
      end

      it 'renders the new template' do
        post :create, upload: invalid_params
        expect(response).to render_template :new
      end
    end
  end
end