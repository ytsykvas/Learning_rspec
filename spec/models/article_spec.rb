require 'rails_helper'

RSpec.describe Article, type: :model do
  context "validation presence." do
    it "Does we need title?" do
      article = Article.new(body: "body body")
      expect(article.valid?).to eq(false) 
    end
    it "Does we need body?" do
      article = Article.new(title: "title title")
      expect(article.valid?).to eq(false) 
    end
    it "Can we save Article?" do
      article = Article.new(title: "title title", body: "body body")
      expect(article.save).to eq(true)
    end
  end
  context "validation langth." do
    it "Short title." do
      article = Article.new(title: "title title", body: "body body")
      expect(article.valid?).to eq(true) 
    end
    it "Long title" do
      article = Article.new(title: "#{"title"*100}", body: "body body")
      expect(article.valid?).to eq(false) 
    end
    it "Short body" do
      article = Article.new(title: "title title", body: "body")
      expect(article.valid?).to eq(false) 
    end
    it "Long body" do
      article = Article.new(title: "title title", body: "#{"body"*100}")
      expect(article.valid?).to eq(true) 
    end
  end
  
  context "scope test." do
    let(:params) { {title: "title title", body: "body body"} }
    before(:each) do
      Article.create(params)
      Article.create(params)
      Article.create(params.merge(active: false))
    end

    it "Can we count active acticles?" do
      expect(Article.active.count).to eq(2) 
    end
    it "Can we count inactive acticles?" do
      expect(Article.inactive.count).to eq(1) 
    end
  end
end
