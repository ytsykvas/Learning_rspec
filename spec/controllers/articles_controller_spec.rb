require 'rails_helper'

RSpec.describe ArticlesController, type: :request do

  let(:params){ { title: "title title", body: "body body" } }

  context "GET #index" do
    it "returns a successful response" do
      get "/articles"
      expect(response).to be_successful
    end  
  end

  context "GET #show" do
    let(:article) { Article.create(params) }
    it "returns a successful response" do
      get "/articles/1", params: { id: article }
      expect(response).to be_successful 
    end
  end

  context "GET #new" do
    it "returns a successful response" do
      get "/articles/new"
      expect(response).to be_successful 
    end
  end

  context "GET #edit" do
    let(:article) { Article.create(params) }
    it "returns a successful response" do
      get "/articles/1/edit", params: { id: article }
      expect(response).to be_successful 
    end
  end

  context "GET #create" do
    let(:article_params){ { title: "title title", body: "body body" } }
    it "returns a successful response" do
      post "/articles", :params => {:article => {title: "title title", body: "body body"}}
      expect(response).to redirect_to(article_url(Article.last))
      follow_redirect!
      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response.body).to include("Article was successfully created.")
    end
  end

  context "#update" do
    let(:new_article_params){ { title: "new title", body: "new body" } }
    before(:each) do
      Article.create(params)
    end
    it "with PATCH" do
      patch "/articles/1", :params => {:article => new_article_params}
      expect(Article.last.title == "new title").to eq(true)
      expect(Article.last.body == "new body").to eq(true)
      expect(response).to redirect_to(article_url(Article.last))
      follow_redirect!
      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response.body).to include("Article was successfully updated.")
    end
    it "with PUT" do
      put "/articles/1", :params => {:article => new_article_params}
      expect(Article.last.title == "new title").to eq(true)
      expect(Article.last.body == "new body").to eq(true)
      expect(response).to redirect_to(article_url(Article.last))
      follow_redirect!
      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response.body).to include("Article was successfully updated.")
    end
  end

  context "GET #destroy" do
    it "description" do
      Article.create(params)
      delete "/articles/1"
      expect(Article.last).to eq(nil)
      expect(response).to redirect_to(articles_url)
      follow_redirect!
      expect(response.body).to include("Article was successfully destroyed.")
    end
  end
end