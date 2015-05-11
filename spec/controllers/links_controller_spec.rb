require 'rails_helper'

describe LinksController do
  let!(:link) { build(:link, id: 1) }

  describe '#new' do
    it 'builds new Link instance' do
      get :new
      expect(assigns(:link)).to be_a_new Link
    end
  end

  describe '#create' do
    let(:params) do
      {
        link: { url: 'http://google.com' }
      }
    end

    context 'with valid params' do
      before do
        expect(Link).to receive(:new).with(params[:link]) { link }
        expect(link).to receive(:save) { true }
        post :create, params
      end

      it 'sets success message' do
        expect(flash[:success]).not_to be_nil
      end

      it 'it redirects to show' do
        expect(response).to redirect_to link_path(link)
      end
    end

    context 'with invalid params' do
      let(:error_message) { 'error message' }
      before do
        expect(Link).to receive(:new).with(params[:link]) { link }
        expect(link).to receive(:save) { false }
        expect(link).to receive(:url_error_message) { error_message }
        post :create, params
      end

      it 'sets error message' do
        expect(flash[:error]).to eq error_message
      end

      it 'it renders :new action' do
        expect(response).to render_template :new
      end
    end
  end

  describe '#show' do
    let(:id) { '1' }
    it 'finds link' do
      expect(Link).to receive(:find).with(id) { link }
      get :show, id: id
      expect(assigns(:link)).to eq link
    end
  end

  describe '#forward' do
    let(:token) { Link.generate_token }

    it 'finds link' do
      expect(Link).to receive(:find_by).with(token: token) { link }
      get :forward, token: token
      expect(response).to redirect_to link.url
    end
  end
end
