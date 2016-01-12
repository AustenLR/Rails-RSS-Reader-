class ArticlesController < ApplicationController
  def index
    feed = Feedjira::Feed.fetch_and_parse("https://www.reddit.com/.rss")
    articles = [];
    feed.entries.each do |entry|
      article = {
        headline: entry.title,
        content: entry.url,
        star: false
        }
      articles.push(article)
    end
    @articles = articles
    @article = Article.new
  end

  def create
    @article = Article.create article_params
    redirect_to articles_path, flash: {success: "'#{@article.headline}'' was added to your favorties"}
  end

  def favorites
    @articles = Article.all
  end

  private

  def article_params
    params.require(:article).permit(
      :headline,
      :content
      )
  end
end
